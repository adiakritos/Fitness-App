class UsersController < ApplicationController

  def edit
    
  end
                                        
  def update
    if current_user.update_attributes!(params[:user])
      flash[:success] = "Your personal settings have been saved!"
      render new_status_update_path
    else
      flash[:error] = "Whoops! There was an error saving your personal settings. Please try again."
      render new_status_update_path
    end
  end

  def show

  end


end
