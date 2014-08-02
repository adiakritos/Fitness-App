class StatusUpdate < ActiveRecord::Base

  belongs_to :client 
  before_save :init

  validates :phase,        presence: true
  validates :entry_date,   presence: true
  validates :total_weight, presence: true, numericality: true
  validates :body_fat_pct, presence: true, numericality: true
  validates :client,       presence: true

  def init     

    if self.body_fat_pct >= 0.5
      self.body_fat_pct /= 100
    elsif self.body_fat_pct <= 0.04
      self.body_fat_pct *= 100
    end 

    prev_stat = self.client.status_updates.where("created_at < ?", self.created_at)[-1]

    if prev_stat == nil
      self.prev_total_weight = self.total_weight
      self.prev_lbm_weight   = self.lbm_weight  
      self.prev_fat_weight   = self.fat_weight  
      self.prev_body_fat_pct = self.body_fat_pct
      self.phase_change_total_weight = self.total_weight
      self.phase_change_lbm_weight   = self.lbm_weight
      self.phase_change_fat_weight   = self.fat_weight
      self.phase_change_body_fat_pct = self.body_fat_pct
    else
       self.prev_total_weight = prev_stat.total_weight
       self.prev_lbm_weight   = prev_stat.lbm_weight
       self.prev_fat_weight   = prev_stat.fat_weight
       self.prev_body_fat_pct = prev_stat.body_fat_pct
      if prev_stat.phase != self.phase
        self.phase_change_total_weight = prev_stat.total_weight
        self.phase_change_lbm_weight   = prev_stat.lbm_weight
        self.phase_change_fat_weight   = prev_stat.fat_weight
        self.phase_change_body_fat_pct = prev_stat.body_fat_pct
      else
        self.phase_change_total_weight = prev_stat.phase_change_total_weight
        self.phase_change_lbm_weight   = prev_stat.phase_change_lbm_weight
        self.phase_change_fat_weight   = prev_stat.phase_change_fat_weight
        self.phase_change_body_fat_pct = prev_stat.phase_change_body_fat_pct
      end
    end

    self.weight_change       = weight_change
    self.lbm_change          = lbm_change
    self.bfp_change          = bfp_change
    self.fat_change          = fat_change
    self.fat_weight          = fat_weight
    self.lbm_weight          = lbm_weight
    self.total_lbm_change    = total_lbm_change
    self.total_fat_change    = total_fat_change
    self.total_bfp_change    = total_bfp_change
    self.total_weight_change = total_weight_change
  end

  def weight_change
    total_weight - prev_total_weight
  end

  def lbm_change
    lbm_weight - prev_lbm_weight
  end

  def fat_change
    fat_weight - prev_fat_weight
  end

  def bfp_change
    body_fat_pct - prev_body_fat_pct
  end

  def fat_weight
    body_fat_pct * total_weight
  end

  def lbm_weight
    total_weight - fat_weight
  end

  def total_weight_change
    total_weight - phase_change_total_weight
  end

  def total_lbm_change
    lbm_weight - phase_change_lbm_weight
  end
  
  def total_fat_change
    fat_weight - phase_change_fat_weight
  end

  def total_bfp_change
    body_fat_pct - phase_change_body_fat_pct 
  end
end



