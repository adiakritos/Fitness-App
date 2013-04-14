class SiteFood < Food
  validates :name, presence: true, uniqueness: true
end
