class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :status_update, dependent: :destroy
  # after_initialize :default_values
  attr_accessor :password, :password_confirmation, :current_password
  attr_accessible :email,
                  :goal,
                  :measurement,
                  :bmr_formula,
                  :fat_factor,
                  :protein_factor,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :deficit_pct,
                  :target_bf_pct,
                  :activity_factor,
                  :current_password
  
                               
  validates :email,           presence: true
  validates :target_bf_pct,   length: { minimum: 3, maximum: 4 },
                              presence: true, 
                              on: :update
  validates :activity_factor, presence: true, on: :update
  validates :deficit_pct,     presence: true, on: :update
 # validates :goal,            presence: true
 # validates :measurement,     presence: true
 # validates :bmr_formula,     presence: true
 # validates :fat_factor,      presence: true
 # validates :protein_factor,  presence: true
 
                  
 # def default_values
 #   self.goal = "Cut"
 #   self.measurement = "US"
 #   self.bmr_formula = "katch"
 #   self.fat_factor = 0.655
 #   self.protein_factor = 1.25 
 #   self.deficit_pct = 0.10
 #   self.target_bf_pct = 0.10
 #   self.activity_factor = 1.3
 # end                   
  
 def new?
   self.created_at <= 1.minutes.ago.to_date ? true : nil
 end

end
