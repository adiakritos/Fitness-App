class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :sanitize

  has_many :status_updates, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :custom_foods, dependent: :destroy
  has_many :meal_foods, through: :meals
  # after_initialize :default_values
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
                  :current_password

  validates :email,                 presence: true
  validates :target_bf_pct,         presence: true, on: :update, length: { minimum: 3, maximum: 4 }
  validates :activity_factor,       presence: true, on: :update
  validates :deficit_amnt,          presence: true, on: :update
  validates :fat_factor,            presence: true, on: :update
  validates :protein_factor,        presence: true, on: :update

  

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
 end

  def end_date             
    if status_updates.count == 0
      Time.now.strftime("%m/%d/%Y")
    else
      (self.start_date + self.time_to_goal.to_i.weeks).strftime("%m/%d/%Y")
    end
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

#  def lbm                  
#    self.latest_status_update.current_lbm
#  end
  
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
     '%.2f' % (370 + (21.6 * cur_lbm.to_d))
  end

  def target_weight
    tar_bf_pct = self.target_bf_pct /= 100
     '%.2f' %  ((self.total_weight * tar_bf_pct)+ self.current_lbm)
  end 

  def fat_to_burn
     '%.2f' % (self.total_weight.to_d - self.target_weight.to_d)
  end

  def tdee
     '%.2f' % (self.bmr.to_d * self.activity_factor.to_d)
  end

  def deficit_pct
    daily_cal_def = ((self.deficit_amnt.to_f * 3500)/7)
     (daily_cal_def.to_d/self.tdee.to_d)
  end

  def daily_calorie_target
     '%.2f' % (self.tdee.to_d * self.deficit_pct.to_d)  
  end

  def weekly_burn_rate
     '%.2f' % (self.daily_calorie_target.to_d*7) 
  end

  def time_to_goal
     '%.2f' %  (self.fat_to_burn.to_d*3500/self.weekly_burn_rate.to_d) 
  end                  

  def daily_intake
     '%.2f' % (self.tdee.to_d - self.daily_calorie_target.to_d)
  end                       

  def total_grams_of(macro)
    self.meal_foods.map(&macro).inject(:+)
  end 

  def pct_fat_satisfied
     #how much of a macro is needed?
     #  fat_needed = fat factor * current lbm
     fat_needed = self.fat_factor * self.current_lbm
     #how much is in the meal?
     fat_provided = self.total_grams_of(:fat)
     #percent needed
     pct_fulfilled = fat_provided.to_f/fat_needed.to_f
     BigDecimal(pct_fulfilled, 2)*100
  end 

  def pct_protein_satisfied
    #how much protien is needed?
    protein_needed = self.protein_factor * self.current_lbm
    #how much protien is provided?
    protein_provided = total_grams_of(:protien)
    #pct of protien satisfied?
    pct_fulfilled = protein_provided.to_f/protein_needed.to_f
    BigDecimal(pct_fulfilled, 2)*100
  end    

  def pct_carbs_satisfied
     #how many carbs are needed?
      cals_required = self.tdee.to_f - (self.tdee.to_f * self.deficit_pct.to_f)
      fat_cals = total_grams_of(:fat) * 9
      protien_cals = total_grams_of(:protien) * 4
     #how many carbs are provided?
      cals_provided = fat_cals + protien_cals
      cals_balance = cals_required - cals_provided
      carbs_needed = cals_balance/4
      carbs_provided = total_grams_of(:carbs)
       BigDecimal(carbs_provided / carbs_needed, 2) * 100

      
  end 
end
