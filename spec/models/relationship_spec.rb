require 'spec_helper'

describe Relationship do
  before(:each) do
    @follower = Factory(:user)
    @follower = Factory(:user, :email => Factory.next(:email))
    @followed = Factory(:user, :email => Factory.next(:email))

    @relationship = @follower.relationships.build(:followed_id => @followed.id)
  end

  it "should create a new instance given valid attributes" do
    @relationship.save!
  end

  describe "follow methods" do
      before(:each) do
      @relationship.save
    end

    it "should have a follower attribute" do
      @relationship.should respond_to(:follower)
    end

    it "should have the right follower" do
      @relationship.follower.should == @follower
    end

    it "should have a followed attribute" do
      @relationship.should respond_to(:followed)
    end

    it "should have the right followed user" do
      @relationship.followed.should == @followed
    end
  end

  describe "validations" do
    it "should require a follower_id" do
      @relationship.follower_id = nil
      @relationship.should_not be_valid
    end

    it "should require a followed_id" do
      @relationship.followed_id = nil
      @relationship.should_not be_valid
    end
  end

  describe "relationships" do
    it "should have a relationships method" do
      @follower.should respond_to(:relationships)
    end

    it "should have a following method" do
      @follower.should respond_to(:following)
    end

    it "should have a following? method" do
      @follower.should respond_to(:following?)
    end

    it "should have a follow! method" do
      @follower.should respond_to(:follow!)
    end

    it "should follow another user" do
      @follower.follow!(@followed)
      @follower.should be_following(@followed)
    end

    it "should include the followed user in the following array" do
      @follower.follow!(@followed)
      @follower.following.should include(@followed)
    end

    it "should have an unfollow! method" do
      @follower.should respond_to(:unfollow!)
    end

    it "should unfollow a user" do
      @follower.follow!(@followed)
      @follower.unfollow!(@followed)
      @follower.should_not be_following(@followed)
    end

    it "should have a reverse_relationships method" do
      @follower.should respond_to(:reverse_relationships)
    end

    it "should have a followers method" do
      @follower.should respond_to(:followers)
    end

    it "should include the follower in the followers array" do
      @follower.follow!(@followed)
      @followed.followers.should include(@follower)
    end
  end
end
