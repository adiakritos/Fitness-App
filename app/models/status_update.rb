
class StatusUpdate < ActiveRecord::Base
   belongs_to :user

   after_initialize :default_values 
   before_save :sanitize 

   attr_accessible :current_weight,
                   :current_bf_pct,
                   :current_lbm,
                   :current_fat_weight,
                   :change_in_weight,
                   :change_in_bf_pct,
                   :change_in_lbm,
                   :change_in_fat_weight,
                   :total_weight_change,
                   :total_bf_pct_change,
                   :total_lbm_change,
                   :total_fat_change,
                   :previous_weight,
                   :previous_bf_pct,
                   :previous_lbm,
                   :previous_fat_weight,
                   :created_at

   validates :user_id, presence: true
   validates :current_bf_pct, presence: true,
                              numericality: true,
                              length: { minimum: 2, maximum:5 }  
   validates :current_weight, presence: true,
                              numericality: true,
                              length: { minimum: 2, maximum:5 } 
   validates :current_lbm, presence: true
   validates :current_fat_weight, presence: true                   
   
   def sanitize     
     if self.current_bf_pct >= 0.5
       self.current_bf_pct /= 100
        if self.current_bf_pct <= 0.04
          self.current_fb_pct *= 100
        end 
     end
     self.current_fat_weight = self.current_weight * self.current_bf_pct
     self.current_lbm = self.current_weight - self.current_fat_weight
   end  

   def default_values
     self.current_bf_pct = 0  if self.current_bf_pct == nil
     self.current_weight = 0   if self.current_weight == nil
     self.current_lbm = 0        if self.current_lbm == nil
     self.current_fat_weight = 0 if self.current_fat_weight == nil
   end
        
   def previous_status_update
     previous_status_update = user.status_update.where( "created_at < ? ", self.created_at ).first   
     if previous_status_update == nil
       return self
     else
       previous_status_update
     end
   end 

   default_scope order: 'status_updates.created_at DESC'

end
