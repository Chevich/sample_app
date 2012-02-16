#coding: utf-8
class PagesController < ApplicationController

  def home
    @title = 'Главная'
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

  def contact
    @title = 'Контакты'
  end

  def about
    @title = 'О нас'
  end

  def help
    @title = 'Помощь'
  end

end