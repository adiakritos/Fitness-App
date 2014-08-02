class StatusUpdatesController < ApplicationController
  before_filter :create_client_session, only: [:show]
  def index
    @status_updates = status_updates.reverse
  end

  def show
    if status_updates?
      @status_update  = status_updates.new
      @status_updates = status_updates.last(5).reverse
      @recent_stat    = status_updates.last
    elsif status_updates? == false
      create_temp
      @recent_stat   = current_client.status_updates.where(temporary: true).first
      @status_update = current_client.status_updates.new
    end
  end         

  def create
    destroy_temp
    @status_update = current_client.status_updates.create(status_updates_params)
    if @status_update.save!
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def destroy
    @status_update = current_client.status_updates.where(id: params[:id]).first
    if @status_update.destroy
      redirect_to status_update_path(current_client.id)
    else
      flash[:notice] = "Not deleted"
    end
  end

  private 

  def status_updates_params
    params.require(:status_update).permit(
      :phase, 
      :total_weight, 
      :body_fat_pct, 
      :entry_date, 
      :id, 

      :weight_change, 
      :lbm_change,
      :bfp_change, 
      :fat_change,
      :fat_weight, 
      :lbm_weight, 
      
      :total_lbm_change, 
      :total_fat_change, 
      :total_bfp_change,
      :total_weight_change,

      :phase_change_total_weight,
      :phase_change_lbm_weight,
      :phase_change_fat_weight,
      :phase_change_body_fat_pct,
                                
      :prev_total_weight,
      :prev_lbm_weight,
      :prev_fat_weight,
      :prev_body_fat_pct        
    ) 
  end                                                                    

  def create_client_session                                            
    session[:current_client] = params[:id]                             
  end                                                                  

  def create_temp
    temp = current_client.status_updates.build(temporary: true, 
                                               phase: 'B', 
                                               entry_date: Date.today, 
                                               total_weight: 0, 
                                               body_fat_pct: 0 , 
                                               client: current_client)
    temp.save! 
  end

  def destroy_temp
    current_client.status_updates.where(temporary: true).destroy_all
  end

end                                                              
                                                                 
                                                              
