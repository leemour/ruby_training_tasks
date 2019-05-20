class Character
  def initialize(health, hit_power_range)
    @health = health
    @hit_power_range = hit_power_range
  end

  def alive? 
    @health > 0
  end

  def set_damage(opponent, damage)
    @health = @health - damage
    log_status(opponent, damage)
  end

  def hit(opponent)
    opponent.set_damage(self, @hit_power_range.sample)
  end

  def log_status(opponent, damage)
    puts "#{opponent.class.name} hits #{self.class.name} for #{damage} damage. #{self.class.name} has #{@health} health left"
  end
end