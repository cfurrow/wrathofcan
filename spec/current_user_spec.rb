require 'spec_helper'

describe 'current_user' do
  before(:each) do
   WarCan::reset 
  end

  it 'can be defined with a block' do
    WarCan::get_current_user_by do
      {:username=>"foo",:password=>"bar"}
    end

    WarCan::current_user_block.should_not be_nil
  end

  it 'is not nil when requested' do
    WarCan::get_current_user_by do
      {:username=>"foo",:password=>"bar"}
    end
    user = WarCan::current_user

    user.should_not be_nil
    user[:username].should == "foo"
    user[:password].should == "bar"
  end

  it 'is nil if block not given' do
    user = WarCan::current_user

    user.should be_nil
  end
end
