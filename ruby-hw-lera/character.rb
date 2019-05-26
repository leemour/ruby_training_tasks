class Character
  def initialize(health, hit_power_range)
    @health = health
    @hit_power_range = hit_power_range
    @available_superhits = 0
  end

  def alive? 
    @health > 0
  end

  def has_superhits?
    @available_superhits > 0
  end

  def take_damage(opponent, damage)
    @health = @health - damage
    log_status(opponent, damage)
  end

  def hit(opponent, superattack = false)
    if superattack && has_superhits?
      opponent.take_damage(self, 2 * @hit_power_range.sample)
      @available_superhits -= 1
    else
      if superattack
        puts "You don't have superattacks"
      end
      opponent.take_damage(self, @hit_power_range.sample)
    end
  end

  def log_status(opponent, damage)
    puts "#{opponent.class} hits #{self.class} for #{damage} damage. #{self.class} has #{@health} health left"
  end

end
