module WarCan
  # Reset the WarCan module by setting the current block to nil
  def self.reset
    @@current_user_block = nil
  end

  # Return the Proc that retrieves the current user
  def self.current_user_block
    @@current_user_block
  end

  # Define the block that is used to get the current user
  def self.get_current_user_by(&block)
    raise ArgumentException unless block_given?
    @@current_user_block = block 
  end

  # Return the current user
  def self.current_user
    return nil if @@current_user_block.nil?
    @@current_user_block.call
  end
end
