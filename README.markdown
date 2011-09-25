# WarCan - A CanCan-like gem 

## Description
WarCan is an attempt to bring CanCan-like abilities to Warden and
Sinatra. It's also one of those "I want to learn this, so I'll create
this" kind of project. I had a need for something like this in one of my
side projects, so here it is.

## Usage

###Create an Ability class:

    require 'warcan'
    class Ability
      include WarCan::Ability

      def initialize(user)
        @user = user

        if user[:is_admin]
          # Define as a method call to "can". 
          can :manage, SecretClass, :active=>true, :user_id=>user[:id]
          can :manage, SecretClass2, :foo=>"bar", :user_id=>user[:id]

          # Or define as a block
          can :view, SecretClass do |the_class|
            the_class.active == true && the_class.user_id == user[:id]
            && user.is_admin 
          end
        end
      end
    end

###Define your model(s) as normal:
In this case, it's a DataMapper object

    class SecretClass
      include DataMapper::Resource
      property :id, Serial
      property :active, Boolean, :default=>false

      # This defines the user_id property for us
      # using DataMappers associations.
      belongs_to :user 

      # ... boring code omitted ...
    end

###Define your user, as normal:

    class User
      attr_accessor :id, :is_admin
      
      # ... code omitted ...
    end

###Use the ability class in your app:

    require 'my_ability'

    class MySinatraApp < Sinatra::Base
      get '/secret/:id' do
        secret_class = SecretClass.get(params[:id])

        # Right now, you have to create the ability object for each
        # request. This will change soon, as I make it a Sinatra Helper.
        # 
        # But, for now, use the syntax below and pass in the warden
        # env['user'] object, which is the current user (or it's nil if
        # the current user is not logged in/authenticated.

        ability = Ability.new(env['user'])  

        # The following will resolve to 'true' if the following criteria
        # are true (they were defined in the Ability class above):
        # - secret_class.active is true 
        # - The current user's id matches secret_class.user_id
        # - The current user is an admin (is_admin==true)

        # Otherwise, it'll return false. Eventually, instead of just
        # returning false, it will throw an authorization exception, and
        # not continue processing the route.

        return "Not authorized" unless ability.can?(:view,secret_class) 

        # At this point, they are considered authorized, and can view
        # the model's details.
        haml :secret, :locals=>{:secret=>secret_class}
      end
    end
