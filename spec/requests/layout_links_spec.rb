# coding: utf-8
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

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector('a', :content => 'Sign in',
                      :href => signin_path)
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email, :with => @user.email
      fill_in :password, :with => @user.password
      click_button "Sign in"
    end

    it "should have a signout link" do
        response.should have_selector('a', :content => 'Sign out',
                      :href => signout_path)
      end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profile")
    end
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        @user = User.new()
        integration_sign_in(@user)
        response.should have_selector("div.flash.error", :content => ~/отсутствует/i)
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        @user = Factory(:user)
        integration_sign_in(@user)
        response.should have_selector("a", :content => "Sign out",
                        :href => signout_path)
        controller.should be_signed_in
        click_link "Sign out"
        response.should have_selector("a", :content => "Sign in",
                        :href => signin_path)
        controller.should_not be_signed_in
      end
    end
  end

end