class StaticPagesController < ApplicationController
  def frontpage
    redirect_to clients_path if trainer_signed_in?
  end
end
