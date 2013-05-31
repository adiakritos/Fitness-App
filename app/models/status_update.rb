
class StatusUpdate < ActiveRecord::Base
   belongs_to :user

   after_initialize :default_values 
   before_create :sanitize 

   attr_accessible :current_weight,
                   :current_bf_pct,
                   :current_lbm,
                   :current_fat_weight,
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
     if self.created_at == nil
      self.current_bf_pct        = 0
      self.current_weight        = 0
      self.current_lbm           = 0    
      self.current_fat_weight    = 0
      self.change_in_weight      = 0 
      self.change_in_bf_pct      = 0
      self.change_in_lbm         = 0
      self.change_in_fat_weight  = 0
      self.total_weight_change   = 0
      self.total_bf_pct_change   = 0
      self.total_lbm_change      = 0
      self.total_fat_change      = 0 
     end
   end
        
   def previous_status_update
     previous_status_update = user.status_updates.where( "created_at < ? ", self.created_at ).first   
     if previous_status_update == nil
       return self
     else
       previous_status_update
     end
   end 
   # CHANGE
   def weight_change
      BigDecimal(self.current_weight - self.previous_weight, 3)
   end

   def lbm_change
      BigDecimal(self.current_lbm - self.previous_lbm, 3)
   end

   def fat_change
      BigDecimal(self.current_fat_weight - self.previous_fat_weight, 3)
   end
  
   # TOTALS
   def total_weight_change

   end

   def total_bf_pct

   end

   def total_fat_weight

   end

   def total_lbm_change

   end

   #PREVIOUS
   def previous_weight
     self.previous_status_update.current_weight
   end

   def previous_lbm
     self.previous_status_update.current_lbm
   end

   def previous_fat_weight
     self.previous_status_update.current_fat_weight
   end

   default_scope order: 'status_updates.created_at DESC'
   
end
