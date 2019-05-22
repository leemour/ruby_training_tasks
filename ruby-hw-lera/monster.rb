require_relative "character"

class Monster < Character

  def initialize() 
    super(25, (1..6).to_a)
  end

end