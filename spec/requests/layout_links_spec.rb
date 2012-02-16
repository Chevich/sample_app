# coding: utf-8
require 'spec_helper'

describe "LayoutLinks -> " do
  
 
  it "should have a Home page at '/'" do 
    get '/'
    response.should have_selector('title', :content => "Главная")
  end 

  it "should have a Contact page!!!" do 
    get 'contact'
    response.should have_selector('title', :content => "Контакты")
  end 
 
  it "should have an About page!!" do
    get 'about'
    response.should have_selector('title', :content => "О нас")
  end 

  it "should have a Help page!!" do  
    get 'help'
    response.should have_selector('title', :content => "Помощь")
  end

  it "should have a Sign Up page!!" do 
    get 'signup'
    response.should have_selector('title', :content => "Регистрация")
  end

  # ссылки на правильные клики мышкой

  it "should have the right links on the layout" do
      visit root_path
      click_link "О нас"
      response.should have_selector('title', :content => "О нас")
      click_link "Помощь"
      response.should have_selector('title', :content => "Помощь")
      click_link "Контакты"
      response.should have_selector('title', :content => "Контакты")
      click_link "Главная"
      response.should have_selector('title', :content => "Главная")
      click_link "Регистрация"
      response.should have_selector('title', :content => "Регистрация")
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector('a', :content => 'Вход',
                      :href => signin_path)
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email, :with => @user.email
      fill_in :password, :with => @user.password
      click_button "Войти"
    end

    it "should have a signout link" do
        response.should have_selector('a', :content => 'Выход',
                      :href => signout_path)
      end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Профиль")
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
        response.should have_selector("a", :content => "Выход",
                        :href => signout_path)
        controller.should be_signed_in
        click_link "Выход"
        response.should have_selector("a", :content => "Вход",
                        :href => signin_path)
        controller.should_not be_signed_in
      end
    end
  end

end