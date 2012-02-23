# coding: utf-8
class SessionsController < ApplicationController
  def new
    @title = "Вход"
  end

  def alter
    @title = "Вход по контрольному вопросу с разрешения администратора"
    @question = '123'
  end

  def create
    s = params[:tag]
    if s == '1'
        user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    else
        user = User.authenticate_by_question(params[:session][:email],
                             params[:session][:answer])
    end
    if user.nil?
      flash.now[:error] = "Пользователь с данными параметрами отсутствует в базе (" +s.class.to_s+")"
      @title = "Вход"
      render :new
    else
      sign_in user
      redirect_back_or user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
