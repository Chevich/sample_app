require 'spec_helper'

describe "LayoutLinks -> " do
  
 
  it "should have a Home page at '/'" do 
    get '/'
    response.should have_selector('title', :content => "Home")
  end 

  it "should have a Contact page!!!" do 
    get 'contact'
    response.should have_selector('title', :content => "Contact")
  end 
 
  it "should have an About page!!" do
    get 'about'
    response.should have_selector('title', :content => "About")
  end 

  it "should have a Help page!!" do  
    get 'help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a Sign Up page!!" do 
    get 'signup'
    response.should have_selector('title', :content => "Sign up")
  end

  # ссылки на правильные клики мышкой

  it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      response.should have_selector('title', :content => "About")
      click_link "Help"
      response.should have_selector('title', :content => "Help")
      click_link "Contact"
      response.should have_selector('title', :content => "Contact")
      click_link "Home"
      response.should have_selector('title', :content => "Home")
      click_link "Sign up now!"
      response.should have_selector('title', :content => "Sign up")
    end  

end