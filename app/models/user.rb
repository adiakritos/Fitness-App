class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :sanitize

  has_many :status_updates, dependent: :destroy
  has_many :meals,          dependent: :destroy
  has_many :custom_foods,   dependent: :destroy
  has_many :meal_foods,     through: :meals

  attr_accessor :user_password, :user_password_confirmation, :current_password
  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :current_password,
                  :goal,
                  :measurement,
                  :bmr_formula,
                  :fat_factor,
                  :protein_factor,
                  :remember_me,
                  :deficit_amnt,
                  :target_bf_pct,
                  :activity_factor,
                  :current_password,
                  :target_caloric_intake

  validates :email,                 presence: true
  validates :target_bf_pct,         presence: true, on: :update, length: { minimum: 3, maximum: 4 }
  validates :activity_factor,       presence: true, on: :update
  validates :deficit_amnt,          presence: true, on: :update
  validates :fat_factor,            presence: true, on: :update
  validates :protein_factor,        presence: true, on: :update
  validates :target_caloric_intake, presence: true, on: :update
  

 def new?
   self.created_at <= 1.minutes.ago.to_date ? true : false
 end

 def sanitize
   #inputs
   self.activity_factor       = 1.3
   self.deficit_amnt          = 1
   self.target_bf_pct         = 10 
   self.fat_factor            = 0.45
   self.protein_factor        = 1
   self.target_caloric_intake = 2500
 end

  def end_date             
    (self.start_date + self.time_to_goal.to_i.weeks).strftime("%m/%d/%Y")
  end

  def start_date           
    self.status_updates.first.created_at
  end

  def daily_caloric_deficit 
    self.tdee.to_d - self.daily_intake.to_d
  end
  
  def current_fat_weight   
    BigDecimal(self.latest_status_update.current_fat_weight, 4)
  end

  def current_lbm          
    BigDecimal(self.latest_status_update.current_lbm, 4)
  end

  def current_bf_pct       
    BigDecimal(self.latest_status_update.current_bf_pct * 100, 4)
  end

  def current_weight       
    BigDecimal(self.latest_status_update.current_weight, 4)
  end

  def total_weight         
    self.latest_status_update.current_weight
  end

  def lbm                  
    self.latest_status_update.current_lbm
  end
  
  def recent_weight_change 
    BigDecimal(self.latest_status_update.current_weight - self.latest_status_update.previous_status_update.current_weight, 2) 
  end

  def recent_lbm_change   
    BigDecimal(self.latest_status_update.current_lbm - self.latest_status_update.previous_status_update.current_lbm, 2)
  end

  def recent_fat_change
    BigDecimal(self.latest_status_update.current_fat_weight - self.latest_status_update.previous_status_update.current_fat_weight, 3)
  end

  def total_lbm_change
    BigDecimal(self.latest_status_update.current_lbm - self.oldest_status_update.current_lbm, 3)
  end

  def total_fat_change 
    BigDecimal(self.latest_status_update.current_fat_weight - self.oldest_status_update.current_fat_weight, 3)
  end

  def total_weight_change
    BigDecimal(self.latest_status_update.current_weight - self.oldest_status_update.current_weight, 3)
  end

  def last_date
    self.status_updates.last.created_at.strftime("%m/%d/%Y") 
  end

  def beginning_date
    self.status_updates.first.created_at.strftime("%m/%d/%Y") 
  end

  def latest_status_update
    self.status_updates.first 
  end

  def oldest_status_update
    self.status_updates.last
  end

  def bmr
    cur_lbm = self.current_lbm
    cur_lbm *= 0.45
    (370 + (21.6 * cur_lbm.to_d)).round
  end

  def target_weight
    tar_bf_pct = self.target_bf_pct /= 100
     '%.2f' %  ((self.total_weight * tar_bf_pct)+ self.current_lbm)
  end 

  def fat_to_burn
     '%.2f' % (self.total_weight.to_d - self.target_weight.to_d)
  end

  def tdee
     self.bmr.to_d * self.activity_factor.to_d
  end

  def deficit_pct
    daily_cal_def = ((self.deficit_amnt.to_f * 3500)/7)
     (daily_cal_def.to_d/self.tdee.to_d)
  end

  def daily_calorie_target
     '%.2f' % (self.tdee.to_d * self.deficit_pct.to_d)  
  end

  def weekly_burn_rate
     '%.2f' % (((self.target_caloric_intake - self.tdee)*7)/3500)
  end

  def time_to_goal
     '%.2f' %  (self.fat_to_burn.to_d*3500/self.weekly_burn_rate.to_d) 
  end                  

  def daily_intake
     '%.2f' % (self.tdee.to_d - self.daily_calorie_target.to_d)
  end                       

  def tdee_plus_ten
     (self.tdee + (self.tdee * 0.1)).round
  end

  def tdee_minus_ten
     (self.tdee - (self.tdee * 0.1)).round
  end
  
  def fat_grams
    self.lbm * self.fat_factor
  end

  def fat_cals
    self.fat_grams * 9
  end

  def fat_pct
    '%.1f' % ((self.fat_cals/self.target_caloric_intake)*100)
  end

  def protein_grams
    self.lbm * self.protein_factor
  end

  def protein_cals
    self.protein_grams * 4
  end

  def protein_pct
    '%.1f' % ((self.protein_cals/self.target_caloric_intake)*100)
  end

  def carb_cals
    essential_cals = self.fat_cals + self.protein_cals
    descretionary_caloric_allowance = self.target_caloric_intake - essential_cals
  end

  def carb_grams
    self.carb_cals / 4
  end

  def carb_pct
    '%.1f' % ((self.carb_cals/self.target_caloric_intake)*100)
  end



#UPDATE MACRO REQUIREMENT METHODS

  def total_grams_of(macro)
    if self.meal_foods.count == 0
      0
    else
      self.meal_foods.map(&macro).inject(:+)
    end
  end 

  def pct_fat_satisfied
    @fat_provided     = self.total_grams_of(:dynamic_fat)
    @fat_grams_needed = self.fat_grams

    if @fat_provided == 0 
      return 0
    elsif @fat_provided != 0
      #self.pct_fat_satisfied = pct_fulfilled
      '%.2f' % ((@fat_provided/@fat_grams_needed)*100)
    end
  end 

  def pct_protein_satisfied
    @protein_provided     = total_grams_of(:dynamic_protein)
    @protein_grams_needed = self.protein_grams

    if @protein_provided == 0 
      return 0
    elsif @protein_provided != 0
      #self.pct_protein_satisfied = pct_fulfilled
      '%.2f' % ((@protein_provided/@protein_grams_needed)*100)
    end
  end    

  def pct_carbs_satisfied
    @carbs_provided = total_grams_of(:dynamic_carbs)
    @carbs_needed   = self.carb_grams

    if @carbs_provided == 0 
      return 0
    elsif @carbs_provided != 0
      #self.pct_carbs_satisfied = @carbs_fulfilled
      '%.2f' % ((@carbs_provided/@carbs_needed)*100)
    end
  end 



#STATUS UPDATE METHODS
  
  def latest_status_update
    if self.status_updates.count == 0
      create_temporary_status_update
    else
      self.status_updates.first 
    end
  end

  def oldest_status_update
    if self.status_updates.count == 0
      create_temporary_status_update
    else
      self.status_updates.last
    end 
  end         
  def create_temporary_status_update
    @status_update = self.status_updates.build(current_bf_pct:     '15', 
                                               current_weight:     '185', 
                                               current_lbm:        '140', 
                                               current_fat_weight: '40', 
                                               temporary:          'true')  
    @status_update.save
  end                   
end


