class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to new_status_update_path
    end 
  end

  def faq
    
  end      

  def contact
    
  end

  def signup

  end
end                                           
