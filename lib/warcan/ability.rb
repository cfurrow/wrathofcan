module WarCan
  module Ability
    # Define an action
    # Examples:
    #
    #   can :view, SomeClass, :user_id=>1, :active=>true
    #   can :manage, SuperSecretClass, :is_admin=>true
    #
    # You can even pass blocks to can():
    #
    #   can :edit, SomeClass do |klass|
    #     klass.active==false
    #   end
    def can(action, *args,&block)
      # add action to the list of rules
      rules << {:action=>action, :args => args, :block=>block}
    end

    # Determine if the current user can perform an 'action'
    # on the pre-defined rules.
    def can?(action, principle)
      matching_rules = rules.select do |item|
        item[:action] == action
      end
      result = true

      matching_rules.each do |rule|
        next unless rule[:args][0] == principle.class

        if rule[:args][1].class == Hash
          rule[:args][1].each_pair do |key,val|
            if principle.respond_to?(key.to_sym)
              result &&= (principle.send(key.to_sym) == val)
            else
              result = false
            end
          end
        elsif rule[:args][1].class == Proc
        end

        if rule[:block]
          result &&= rule[:block].call(principle)
        end

      end

      result
    end

    # The rules collection 
    def rules
      @rules ||= []
    end

    private

    def matches?(principle, rule)
      # a principle has attributes
      # rule has rules to match against attributes
    end
  end
end
