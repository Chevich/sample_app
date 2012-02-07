require 'spec_helper'

describe "LayoutLinks -> " do
  #render_views 
 
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
end