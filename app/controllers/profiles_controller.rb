#!/usr/bin/env ruby
# encoding: utf-8
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def index
    if current_user and current_user.has_role?("admin")
      @profiles = Profile.all
    else
      redirect_to profile_path(current_user.id)
    end
  end

  def show
    @title = "رویداد‌های من"
    @events = @profile.my_events.order(:begins).reverse_order
  end

  def edit
    if !current_user or (!current_user.has_role?("admin") and current_user.profile != @profile)
      redirect_to events_path
    end

  end
  
  def update
    if @profile.update(profile_params)
      redirect_to events_path
    else
      puts":::::::::::::::::::"
      @profile.errors.messages.each do |e|
        puts e
      end
      puts"<<<<<<<<<<<<<<<<<<<<"
      render action: 'edit', :alert => 'data validation failed.'
    end
  end
  
  private
  
  def profile_params
    params.require(:profile).permit(:name, :surname, :avatar, :phone_number,:tag_list,:avatar)
  end
  
  def set_profile
    @profile = Profile.find_by_id(params[:id])

  end
end
