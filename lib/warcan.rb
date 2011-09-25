module WarCan
  module Ability

    def can(action, *args,&block)
      # add action to the list of rules
      rules << {:action=>action, :args => args, :block=>block}
    end

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

    def rules
      @rules ||= []
    end

    private

    def matches?(principle, rule)
      # a principle has attributes
      # rule has rules to match against attributes
    end
  end


  def self.reset
    @@current_user_block = nil
  end

  def self.current_user_block
    @@current_user_block
  end

  def self.get_current_user_by(&block)
    @@current_user_block = block 
  end

  def self.current_user
    return nil if @@current_user_block.nil?
    @@current_user_block.call
  end
end
