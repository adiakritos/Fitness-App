module ApplicationHelper
include StatusUpdatesHelper
  def full_title(page_title)
    base_title = "Welcome to the Fitness App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end 
  
  def round( input )
    '%.2f' % input
  end  
  
end

