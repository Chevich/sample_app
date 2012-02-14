require 'spec_helper'

describe Micropost do

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end
  describe "micropost associations" do

    before(:each) do
      @user123 = Factory(:user, :email => "new@tut.by")
      @mp1 = Factory(:micropost, :user => @user123, :created_at => 1.day.ago)
      @mp2 = Factory(:micropost, :user => @user123, :created_at => 1.hour.ago)
    end

    it "should have a microposts attribute" do
      @user123.should respond_to(:microposts)
    end

    it "should have the right microposts in the right order" do
      @user123.microposts.should == [@mp2, @mp1]
    end

    it "should destroy associated microposts" do
      @user123.destroy
      [@mp1, @mp2].each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

    describe "validations" do

      it "should require a user id" do
        Micropost.new(@attr).should_not be_valid
      end

      it "should require nonblank content" do
        @user.microposts.build(:content => "  ").should_not be_valid
      end

      it "should reject long content" do
        @user.microposts.build(:content => "a" * 141).should_not be_valid
      end
    end

    describe "status feed" do

      before(:each) do
        @user2 = Factory(:user, :email => "new2@tut.by")
        @mp21 = Factory(:micropost, :user => @user2, :created_at => 1.day.ago)
        @mp22 = Factory(:micropost, :user => @user2, :created_at => 1.hour.ago)
      end

      it "should have a feed" do
        @user2.should respond_to(:feed)
      end

      it "should include the user's microposts" do
        @user2.feed.include?(@mp21).should be_true
        @user2.feed.include?(@mp22).should be_true
      end

      it "should not include a different user's microposts" do
        mp3 = Factory(:micropost,
                      :user => Factory(:user, :email => Factory.next(:email)))
        @user2.feed.include?(mp3).should be_false
      end
    end
  end


end