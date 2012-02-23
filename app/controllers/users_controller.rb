# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def feed
    Micropost.from_users_followed_by
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def filter
    @filter_str = params[:user][:word]
    @title = "Отбор пользователей по фрагменту #{@filter_str}"
    @users = User.filtered(@filter_str).paginate(:page => params[:page])
  end

  def index
    @title = "Список всех пользователей"
    @users = User.paginate(:page => params[:page])
    #@users = User.all
  end

  def new
    redirect_to root_path unless current_user?(@user)
    @title = 'Регистрация'
    @user = User.new
  end

  def edit
    @title = 'Настройки'
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Профиль обновлен."
      redirect_to @user
    else
      @title = "Настройки"
      render 'edit'
    end
  end

  def create
    redirect_to root_path unless current_user?(@user)
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Добро пожаловать в Твиттер-шмиттер"
      redirect_to @user
    else
      @title = "Регистрация"
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

  def followers
    @title = "Следящие"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def following
    @title = "Наблюдаемые"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
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
