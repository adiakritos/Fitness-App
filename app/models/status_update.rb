class StatusUpdate < ActiveRecord::Base
  belongs_to :user

  before_create :sanitize 

  attr_accessible :current_weight,
                  :current_bf_pct,
                  :current_lbm,
                  :current_fat_weight,
                  :created_at,
                  :temporary

  validates :user_id,            presence: true
  validates :current_bf_pct,     presence: true, numericality: true, length: { minimum: 2, maximum:5 }  
  validates :current_weight,     presence: true, numericality: true, length: { minimum: 2, maximum:5 } 
  validates :current_lbm,        presence: true
  validates :current_fat_weight, presence: true                   
  validates :temporary,          presence: true
  
 

  # CURRENT
  def current_fat_weight
    self.current_weight * self.current_bf_pct 
  end

  def current_lbm
    self.current_weight - self.current_fat_weight 
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

  # PREVIOUS
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

  def previous_status_update
    previous_status_update = user.status_updates.where( "created_at < ? ", self.created_at ).first   
    if previous_status_update == nil
      return self
    else
      previous_status_update
    end
  end 

  private 

  def sanitize     
    if self.current_bf_pct >= 0.5
      self.current_bf_pct /= 100
    elsif self.current_bf_pct <= 0.04
      self.current_fb_pct *= 100
    end 
  end  
 
end
