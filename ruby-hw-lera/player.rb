class Player < Character

  def initialize 
    super(30, (2..5).to_a)
    @available_superhits = 1
  end

  def hit(opponent)
    loop do
      command = Console.get_command()

      case command
      when 'hit'
        super(opponent)
        break;
      when 'superhit'
        if has_superhits? 
          super(opponent, true)
          @available_superhits -= 1
        else 
          puts 'You already used superhit!'
          redo
        end
        break;
      when 'quit'
        exit
      else 
        puts 'Invalid command'
        redo
      end
    end
  end

  def has_superhits?
    @available_superhits > 0
  end

end