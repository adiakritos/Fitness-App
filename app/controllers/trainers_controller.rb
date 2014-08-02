class TrainersController < ApplicationController
  before_filter :authenticate_user!

  private 

  def trainers_params
    params.require(:trainers).permit(:email, :password)
  end
end
