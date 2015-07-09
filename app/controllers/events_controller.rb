#!/usr/bin/env ruby
# encoding: utf-8
class EventsController < ApplicationController
  before_action :authenticate_user!, :only => [:book, :cancel_book, :edit, :new]
  before_action :complete_profile
  before_action :set_event, :only => [:book_conference, :book, :cancel_book, :edit, :update, :show, :destroy, :start_register]

  def index
    #@events = Event.all
    render 'events/choser', layout: false
  end 

  def admin_index
    if current_user and current_user.has_role?("admin")
      @events = Event.all
      render 'events/admin/admin_index'
    else
      redirect_to events_path
    end
  end

  def filter_by_category
    category = params[:category]
    if category == 'Class' or category == 'Ring' or category == 'Lab' or category == 'Workshop' or category=='Conference' or category=='Talk'
      @events = Event.where("category = ?", category).where("begins > ?", Time.now).order(:begins)
      @archives = Event.where("category = ?", category).where("begins < ?", Time.now).order(:begins)
      @title = "رویدادها"
      if category == 'Class'
        @title = "کلاس‌ها"
      elsif category == 'Ring'
        @title = "حلقه‌ها"
      elsif category == 'Lab'
        @title = "آزمایشگاه و کارآموزی"
      elsif category == 'Workshop'
        @title = "ورک‌شاپ‌ها"
      elsif category == 'Conference'
	      @title = "همایش ها"
      elsif category == 'Talk'
	      @title = 'تاک ها'
      end
      render 'events/index'
    else
      redirect_to events_path
    end
  end

  def filter_by_year
    year = params[:year]
    all=Event.where("begins >= ?",Parsi::Date.new(year.to_i,1,1).to_gregorian()).where("begins <= ?",Parsi::Date.new(year.to_i+1,1,1).to_gregorian())
    @events=all.where("begins > ?", Time.now).order(:begins)
    @archives=all.where("begins < ?", Time.now).order(:begins)
    @title = 'تمامی رویدادهای سال '+year.to_s
    render 'events/index'
  end

  def show
    # authorize_action_for @event
  end

  def new
    @event = Event.new
    authorize_action_for @event
  end

  def create
    @event = Event.new(event_params)
    authorize_action_for @event
    if @event.save
      redirect_to root_path
    else
      render action: 'new', :alert => 'data validation failed.'
    end
  end

  def edit

  end

  def update
    authorize_action_for @event
    respond_to do |format|
      if @event.update(event_params)
        format.html {
          redirect_to events_path, notice: 'Event was successfully updated.'
        }
        #format.json { render :show, status: :ok, location: @cloth_part }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize_action_for @event
    @event.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Officership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def prebuy
    authenticate_user!
    @profile = current_user.profile
    @participation = Participation.where("profile_id = ?",@profile.id).where("event_id = ?",params[:event]).first
    @event = Event.find(params[:event])
    if @participation.profile != current_user.profile or Time.now > @event.begins
      redirect_to events_path
      return
    end
    if @participation.payed
      render 'events/successbuy'
    elsif @participation.check_credit
      render 'events/errorbuy'
    else
      render 'events/prebuy'
    end
  end


  def buy
    authenticate_user!
    @profile = current_user.profile
    @participation = Participation.find(params[:participation])
    if @participation.profile != current_user.profile
      redirect_to @profile
      return
    end
    if @participation.payed
      render 'events/successbuy'
    elsif @participation.check_credit
      render 'events/errorbuy'
    else
      if @participation.buy(@profile)
        render 'events/successbuy'
      else
        redirect_to @participation.event, :notice => "فرآیند خرید با اشکال روبه‌رو شد."
      end
    end
  end


  def participation_index
    authenticate_user!
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @participations = Participation.all
    render 'events/participation_index'
  end

  def participation_new
    #puts "AA"
    authenticate_user!
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @participation = Participation.new
    puts "SS " + @participation.to_s
    render 'events/participation_new'
  end

  def participation_create
    puts "SSS"
    authenticate_user!
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    #puts participation_params
    #puts "AAAAAAAAAA"
    @participation = Participation.new(participation_params)
    @profile = @participation.profile
    if @participation.save
      if @participation.buy(@profile)
        redirect_to participation_index, :notice => "خرید این رویداد موفقیت‌آمیز بود"
      else
        # puts "::::::::::::::::::::::::::::",@participation.errors.messages
        redirect_to @participation.event, :notice => "فرآیند خرید با اشکال روبه‌رو شد."
      end
    end
  end

  def participation_destroy
    authenticate_user!
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @participation = Participation.find(params[:id])
    @participation.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Participations was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def participation_params
    params.require(:participation).permit(:profile_id, :event_id)
  end

  def search
    if (params[:tags] || params[:name])
      @all=Event.tagged_with(params[:tags],:any=>true)
      @all=@all.where("title LIKE '#{params[:name]}' OR sentence LIKE '#{params[:name]}' OR description LIKE '#{params[:name]}' OR summary LIKE '#{params[:name]}'") if params[:name] && params[:name]!=""
      @events=@all.where("begins > ?", Time.now).order(:begins)
      @archives=@all.where("begins < ?", Time.now).order(:begins)
      render 'events/index'
    else
      render 'events/search'
    end
  end

  def manual_buy
    authenticate_user!
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @participation = Participation.find(params[:id])
    @profile = @participation.profile
    if @participation.payed
      render 'events/successbuy'
    elsif @participation.check_credit
      render 'events/errorbuy'
    else
      if @participation.buy(@profile)
        redirect_to participation_index, :notice => "خرید این رویداد موفقیت‌آمیز بود"
      else
        redirect_to @participation.event, :notice => "فرآیند خرید با اشکال روبه‌رو شد."
      end
    end
  end



  def start_register
    if current_user.has_role?(:admin)
      @event.participants.each do |p|
        UserMailer.start_register(p,@event).deliver
      end
      redirect_to admin_path, :notice => 'Send mails to ' + @event.title + ' participants'
      return
    end
    redirect_to events_path
  end

  def temp_start_all
    if current_user.has_role?(:admin)
      Profile.all.each do |p|
        UserMailer.send_all_register(p).deliver
      end
      redirect_to admin_path, :notice => 'Send mails to ' +' participants'
      return
    end
    redirect_to events_path
  end


  def book_conference
    authenticate_user!
    @profile = current_user.profile
    if !(@profile.book_conference(@event,PriceModel.where(:id=>params[:price_model_id]).first))
      @error = "Event is full!"
    else
      participation = Participation.where("event_id = ?", @event.id).where("profile_id = ?",@profile.id).first
      participation.notify_book
    end
  end


  def book
    authenticate_user!
    @profile = current_user.profile
    if !(@profile.book(@event))
      @error = "Event is full!"
    else
      participation = Participation.where("event_id = ?", @event.id).where("profile_id = ?",@profile.id).first
      participation.notify_book
    end
  end

  def cancel_book
    authenticate_user!
    @profile = current_user.profile
    #@event.participations << Participation.new(:event => @event, :profile => @profile)
    @profile.cancel_book(@event)
    #  redirect_to events_path
    #else
    #  redirect_to events_path, :alert => "SAA"
    #end
  end

  private

  def event_params
    params.require(:event).permit(:title, :sentence, :description, :summary, :begins, :venue, :category, :capacity, :price, :poster,:tag_list, :officer_ids => [],:is_conference_like)
    # params.permit!
  end

  def set_event
    @event = Event.find_by_id(params[:id])
    #puts @event.id.to_s() + " " + @event.sentence
  end
end
