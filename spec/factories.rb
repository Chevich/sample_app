# Используя символ ':user', мы указываем Factory Girl на необходимость симулировать модель User.
FactoryGirl.define do
  factory :user do
    name                  "xxxxxx"
    email                 "xxxxx@tut.by"
    password              "foobar"
    password_confirmation "foobar"
  end
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end