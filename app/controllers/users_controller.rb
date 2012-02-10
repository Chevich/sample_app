class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end  

  def new
    @title = 'Sign up'  
    @user = User.new
  end

  def edit
    @title = 'Edit user'
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

end
