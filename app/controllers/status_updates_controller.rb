require 'rubygems'
require 'active_support/core_ext/numeric/time'
class StatusUpdatesController < ApplicationController
  include StatusUpdatesHelper

  before_filter :correct_user, only: [:destroy, :delete_all]
  before_filter :destroy_temporary, only: :create
  before_filter :status_updates_empty?, only: [:new, :show]

  def create
    @status_update = current_user.status_updates.build(params[:status_update])
    @status_update.temporary = 'false'
    if @status_update.save
      flash[:success] = "Status Update Saved! #{params[:status_update]}"
      redirect_to new_status_update_path
    else
      flash[:error] = "Status Updates couldn't be saved. :/"
      redirect_to new_status_update_path
    end 
  end 
  
  def new
    @status_update = current_user.status_updates.build if user_signed_in?
  end

  def show
    @user = User.find(params[:id])
    @status_updates = @user.status_updates
  end

  def destroy
    @status_update.destroy
    flash[:success] = "Status update deleted!"
    redirect_to status_update_path(current_user.id)
  end

  def delete_all
    @all_status_updates = current_user.status_updates
    @all_status_updates.destroy_all
    if @all_status_updates.count == 0
      flash[:success] = "All status updates deleted!"
      redirect_to status_update_path(current_user.id)
    else
      flash[:error] = "Could not reset"
      redirect_to status_update_path(current_user.id)
    end
  end

  private

  def correct_user
    @status_update = current_user.status_updates
    redirect_to root_url if @status_update.nil?
  end 

  def destroy_temporary
    if current_user.status_updates.find_by_temporary('true') 
      current_user.status_updates.find_by_temporary('true').destroy
    end
  end
  
  def status_updates_empty?
    if current_user.status_updates.count == 0 
      current_user.create_temporary_status_update
    end
  end

end




