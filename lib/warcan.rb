module WarCan
  module Ability
    
    def can(action, *args)

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
