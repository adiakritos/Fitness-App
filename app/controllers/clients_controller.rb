class ClientsController < ApplicationController
  before_action :logout_client, only: :index

  def index
    @active_clients   = current_trainer.active_clients
    @inactive_clients = current_trainer.inactive_clients
    @client           = current_trainer.clients.new
  end

  def create
    @client = current_trainer.clients.create(client_params)
    respond_to do |format|
      format.html { redirect_to clients_path }
      format.js 
    end
  end

  def update
    @client = Client.find(params[:id])
    @client.update_attributes!(client_params)
    redirect_to meal_path
  end                           

  private 

  def logout_client
    if client_session_active?
      session[:current_client].clear
    end
  end

  def check_set_temp
    create_temp_status_update
  end

  def client_params
    params.require(:client).permit(
      :firstname, 
      :lastname, 
      :fat_factor, 
      :protein_factor, 
      :activity_level, 
      :target_calories, 
      :status, 
      :email, 
      :trainer)
  end
end
