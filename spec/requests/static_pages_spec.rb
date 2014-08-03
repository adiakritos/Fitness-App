require 'spec_helper'

describe "Static Pages" do

  subject { page }

  describe "Home page" do
    it "should have title content with 'home' in it" do
      visit root_path
      should have_selector( 'title', :text => "| Home")
    end
  end

  describe "FAQ page" do
    it "should have title content with 'home' in it" do
      visit faq_path
      should have_selector( 'title', :text => "| FAQ")
    end
  end
  
  describe "Contact Page" do
     it "should have title content with 'contact' in it" do
      visit contact_path
      should have_selector( 'title', :text => "| Contact")
    end 
  end
    
  it "should have the right links on the layout" do
    visit root_path

    click_link "Home"
    page.should have_selector 'title', text: "Home"
    click_link "Contact"
    page.should have_selector 'title', text: "Contact"
    click_link "FAQ"
    page.should have_selector 'title', text: "FAQ"
  end
    

end

