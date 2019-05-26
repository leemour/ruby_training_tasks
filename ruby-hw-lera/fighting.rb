class Fighting
  attr_reader :fighter1, :fighter2
  
  def initialize(fighters)
    @fighter1, @fighter2 = fighters
  end
  
  def process
    loop do
      fighter1.hit(fighter2)
      if !fighter2.alive?
        return self
      end
    
      fighter2.hit(fighter1)
      if !fighter1.alive?
        return self
      end
    end
  end
  
  def somebody_died?
    !fighter1.alive? || !fighter2.alive?
  end
  
  def output
    if fighter1.alive? && fighter1.class.name != 'Player'
      puts 'You lose'
    else
      puts 'You win'
    end
  end
end
