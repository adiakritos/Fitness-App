module ApplicationHelper

  #general helpers

  def round(num)
    sprintf('%.2f', num)
  end

  #client helpers

  def current_client
    current_trainer.clients.where(id: session[:current_client]).first
  end

  def client_session_active?
    trainer_signed_in? and session[:current_client].present?
  end

  #status_updates helpers

  def status_updates?
    current_client.status_updates.any? 
  end

  def status_updates
    StatusUpdate.where("client_id = ?", current_client.id)
  end   

end
