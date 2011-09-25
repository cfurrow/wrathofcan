require 'spec_helper'

class Class
  attr_accessor :active, :user_id

  def find(*args)
    Class.new(:active=>true)
  end
end

class Class2
  attr_accessor :foo

  def find(*args)
    Class2.new(:foo=>"baz")
  end
end
class Ability
  include WarCan::Ability

  def initialize(user)
    @user = user

    if user[:is_admin]
      can :manage, Class, :active=>true, :user_id=>user[:id]
      can :manage, Class2, :foo=>"bar", :user_id=>user[:id]

      can :view, Class do |the_class|
        the_class.active == true && the_class.user_id == user[:id]
      end
    end
  end
end

describe 'can' do
  before(:each) do
    WarCan::get_current_user_by do
      {:id=>1,:is_admin=>true}
    end
  end

  it 'can be used to define a rule' do
    ability = Ability.new(WarCan::current_user)

    ability.rules.size.should == 3
  end
end

describe 'can?' do
  before(:each) do
    WarCan::get_current_user_by do
      {:id=>1,:is_admin=>true}
    end
  end

  it 'can be used to check a rule' do

    ability = Ability.new(WarCan::current_user)

    test_class = Class.new
    test_class.active=true
    test_class.user_id=1

    ability.can?(:manage, test_class).should be_true
    ability.can?(:view, test_class).should be_true

    test_class = Class2.new
    ability.can?(:manage, test_class).should be_false

  end
end
