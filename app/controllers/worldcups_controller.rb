#!/usr/bin/env ruby
# encoding: utf-8
class WorldcupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_worldcup, only: [:show, :edit, :update, :destroy]

  # GET /worldcups
  # GET /worldcups.json
  def index
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @worldcups = Worldcup.all
  end

  # GET /worldcups/1
  # GET /worldcups/1.json
  def show
    redirect_to events_path
    return

  end

  # GET /worldcups/new
  def new
    redirect_to events_path
    return
    if current_user.profile.worldcup.nil? == false
      redirect_to current_user.profile.worldcup
      return
    end
    @worldcup = Worldcup.new
  end

  # GET /worldcups/1/edit
  def edit
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
  end

  # POST /worldcups
  # POST /worldcups.json
  def create

    if current_user.profile.worldcup.nil? == false
      redirect_to current_user.profile.worldcup
      return
    end

    @worldcup = Worldcup.new(worldcup_params)
    @worldcup.profile = current_user.profile
    respond_to do |format|
      if @worldcup.save
        format.html { redirect_to @worldcup, notice: 'پیش‌بینی شما ثبت شد!' }
        format.json { render :show, status: :created, location: @worldcup }
      else
        format.html { render :new }
        format.json { render json: @worldcup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /worldcups/1
  # PATCH/PUT /worldcups/1.json
  def update
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    respond_to do |format|
      if @worldcup.update(worldcup_params)
        format.html { redirect_to @worldcup, notice: 'Worldcup was successfully updated.' }
        format.json { render :show, status: :ok, location: @worldcup }
      else
        format.html { render :edit }
        format.json { render json: @worldcup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /worldcups/1
  # DELETE /worldcups/1.json
  def destroy
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @worldcup.destroy
    respond_to do |format|
      format.html { redirect_to worldcups_url, notice: 'Worldcup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worldcup
      @worldcup = Worldcup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def worldcup_params
      params.require(:worldcup).permit( :germany_goal, :argentina_goal)
    end
end
