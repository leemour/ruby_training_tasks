class Player < Character

  def initialize 
    super(30, (2..5).to_a)
    @available_superhits = 1
  end

  def hit(opponent)
    command = Console.gets('attack_type')

    case command
    when 'hit'
      super(opponent)
    when 'superhit'
      super(opponent, true)
    end
  end

end
