class UserMailer < ActionMailer::Base
  default from: "twitter.schmitter@gmail.com"

  def welcome_email(user)
      @user = user
      @url  = '123123'
      mail(:to => user.email, :subject => "Welcome to My Awesome Site")
    end
end
