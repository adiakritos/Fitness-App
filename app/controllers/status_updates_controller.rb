require 'rubygems'
require 'active_support/core_ext/numeric/time'
class StatusUpdatesController < ApplicationController
  include StatusUpdatesHelper

  before_filter :correct_user, only: [:destroy, :delete_all]

  def create
    @status_update = current_user.status_update.build(params[:status_update])
    if @status_update.save
      flash[:success] = "Status Update Saved!"
     # redirect_to status_update_path(current_user.id)
      redirect_to new_status_update_path
    else
      flash[:error] = "Input Error - Couldn't Save Status Update"
      redirect_to new_status_update_path
    end 
  end 
  
  def new
    @status_update = current_user.status_update.build if user_signed_in?
  end

  def show
    @user = User.find(params[:id])
    @status_updates = @user.status_update
  end

  def destroy
    @status_update.destroy
    flash[:success] = "Status update deleted!"
    redirect_to status_update_path(current_user.id)
  end

  def delete_all
    @all_status_updates = current_user.status_update
    @all_status_updates.delete_all
    flash[:success] = "All status updates deleted!"
    redirect_to status_update_path(current_user.id)
  end

  private

  def correct_user
    @status_update = current_user.status_update.find_by_id(params[:id])
    redirect_to root_url if @status_update.nil?
  end 
  
end




