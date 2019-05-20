require_relative "character"

class Player < Character

  def initialize() 
    super(30, (2..5).to_a)
    @available_superhits = 1
  end

  def superhit(opponent)
    opponent.set_damage(self, 2 * @hit_power_range.sample)
    @available_superhits -= 1
  end

  def has_superhits?
    @available_superhits > 0
  end

end