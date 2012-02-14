class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def index
    @title = "Index list of all users"
    @users = User.paginate(:page => params[:page])
    #@users = User.all
  end

  def new
    redirect_to root_path unless current_user?(@user)
    @title = 'Sign up'
    @user = User.new
  end

  def edit
    @title = 'Edit user'
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def create
    redirect_to root_path unless current_user?(@user)
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

  def destroy
    @usr = User.find(params[:id])
    str = @usr.name
    if current_user.admin? && @usr==current_user
      flash[:success] = "Admins can't delete yourselves."
      redirect_to users_path
    else
      @usr.destroy
      flash[:success] = "User <<#{str}>> destroyed."
      redirect_to users_path
    end
  end

private

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
