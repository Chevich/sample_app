# Используя символ ':user', мы указываем Factory Girl на необходимость симулировать модель User.
FactoryGirl.define do
  factory :user do
    name                  "Andy Chevich"
    email                 "Andy.Chevich@gmail.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end  