class SiteFood < Food
  validates :name, uniqueness: true
end
