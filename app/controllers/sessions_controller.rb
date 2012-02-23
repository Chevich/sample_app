# coding: utf-8
class SessionsController < ApplicationController
  def new
    @title = "Вход"
  end

  def alter
    @title = "Вход по контрольному вопросу. Этап 1"
    flash.now[:success] = "Внимание: Данный способ небезопасен. Не злоупотребляйте им!"
  end

  def mail_check
    user = User.question_by_mail(params[:session][:email])
    if user.nil?
      flash.now[:error] = "Пользователь с данным email отсутствует в базе"
      @title = "Вход по контрольному вопросу. Этап 1"
      render :alter
    else
      @title = "Вход по контрольному вопросу. Этап 2"
      @question = user.question
      @email = user.email
    end
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
      flash.now[:error] = "Пользователь с данными параметрами отсутствует в базе"
      @title = "Вход"
      render :new
    else
      sign_in user
      if s==1
        redirect_back_or user
      else
        redirect_to(edit_user_path(user))
      end
    end
  end

  def question?

  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
