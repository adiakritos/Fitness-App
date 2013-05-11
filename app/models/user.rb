class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :sanitize

  has_many :status_update, dependent: :destroy
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
  
                               
  validates :email,           presence: true
  validates :target_bf_pct,   length: { minimum: 3, maximum: 4 },
                              presence: true, 
                              on: :update
  validates :activity_factor, presence: true, on: :update
  validates :deficit_amnt,    presence: true, on: :update
 # validates :goal,           presence: true
 # validates :measurement,    presence: true
 # validates :bmr_formula,    presence: true
  validates :fat_factor,     presence: true, on: :update
  validates :protein_factor, presence: true, on: :update
 
  
 def new?
   self.created_at <= 1.minutes.ago.to_date ? true : nil
 end

 def sanitize
   self.activity_factor = 3
   self.deficit_amnt = 1
   self.target_bf_pct = 10 
   self.fat_factor = 0.45
   self.protein_factor = 1
 end
 

 
  
end
