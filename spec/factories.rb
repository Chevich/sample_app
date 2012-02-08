# Используя символ ':user', мы указываем Factory Girl на необходимость симулировать модель User.
Factory.define :user do |user|
  user.name                  "Andy Chevich"
  user.email                 "Andy.Chevich@gmail.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end