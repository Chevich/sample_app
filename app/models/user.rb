# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :question, :answer

  has_many :microposts, :dependent => :destroy


  has_many :relationships,  :foreign_key => "follower_id",
                            :class_name => "Relationship",
                            :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed


  has_many :reverse_relationships,  :foreign_key => "followed_id",
                                    :class_name => "Relationship",
                                    :dependent => :destroy
  has_many :followers, :through => :reverse_relationships#, :source => :follower

 
 #email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  email_regex = /[\w\d\-.]+@[a-z\d\-.]+\.[a-z\d]+/i

  validates :name, :presence => true,  
    :length   => { :maximum => 50 }
  validates :email, :presence => true,
    :format   => { :with => email_regex },
    :uniqueness => { :case_sensitive => false }
  validates :password, :confirmation => true,
    :presence => true,
    :length => { :within => 6..40 }
  validates :question, :presence => true
  validates :answer, :presence => true

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user = find_by_name(email) if user.nil?
    (user && user.has_password?(submitted_password)) ? user : nil
  end

  def self.authenticate_by_question(email, answer)
    find_by_email_and_answer(email, answer)
    #(user && user.has_password?(submitted_password)) ? user : nil
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def following?(followed)
    self.relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    self.relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(self.password)
    end

    def encrypt(string)
      secure_hash("#{self.salt}--#{string}")
    end 
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end 
end
