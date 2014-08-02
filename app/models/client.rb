class Client < ActiveRecord::Base
  belongs_to :trainer
  has_many :status_updates
  has_many :meals
  has_many :meal_foods, through: :meals

  before_create :init
  
  validates :firstname, :lastname, presence: true

  def init
   self.activity_level  = 1.3
   self.fat_factor      = 0.45
   self.protein_factor  = 1
   self.target_calories = 2500
  end
    
  def recent_status_update
    self.status_updates.first
  end

  def lbm
    recent_status_update.lbm_weight
  end

  def bmr
     370 + (21.6 * (lbm * 0.45))
  end

  def tdee
     self.activity_level * bmr
  end

  def required_fat
     self.fat_factor * lbm
  end

  def required_carbs
     self.target_calories / 4
  end

  def required_protein
    self.protein_factor * (lbm * 0.45)
  end

  def pct_of_target_cals
    (1-(tdee/self.target_calories))*100
  end

  #Macro Update Methods

  def total_grams_of(macro)
    if self.meal_foods.count == 0
      0
    else
      self.meal_foods.map(&macro).inject(:+)
    end
  end

  def pct_fat_satisfied
    @fat_provided     = self.total_grams_of(:dynamic_fat)
    @fat_grams_needed = self.required_fat

    if @fat_provided == 0 
      return 0
    elsif @fat_provided != 0
      '%.2f' % ((@fat_provided/@fat_grams_needed)*100)
    end
  end

  def pct_carbs_satisfied
    @carbs_provided = total_grams_of(:dynamic_carbs)
    @carbs_needed   = self.required_carbs

    if @carbs_provided == 0 
      return 0
    elsif @carbs_provided != 0
      #self.pct_carbs_satisfied = @carbs_fulfilled
      '%.2f' % ((@carbs_provided/@carbs_needed)*100)
    end
  end

  def pct_protein_satisfied
    @protein_provided     = total_grams_of(:dynamic_protein)
    @protein_grams_needed = self.required_protein

    if @protein_provided == 0 
      return 0
    elsif @protein_provided != 0
      #self.pct_protein_satisfied = pct_fulfilled
      '%.2f' % ((@protein_provided/@protein_grams_needed)*100)
    end
  end

end
