namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    create_users
    create_microposts
    create_relationships
  end
end

def create_users
  admin = User.create!(:name => "andy",
               :email => "example@railstutorial.org",
               :password => "foobar",
               :password_confirmation => "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@tut.by"
    password  = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end

end

def create_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end
end

def create_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each{|followed| user.follow!(followed)}
  followers.each{|follower| follower.follow!(user)}
end