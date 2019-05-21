class Game

  def initialize
    @fighters= []
  end

  def start
    choose_order

    puts 'FIGHT!'

    while @fighters[0].alive? && @fighters[1].alive? do
      @fighters[0].hit(@fighters[1])
      @fighters[1].hit(@fighters[0])
    end

    if @fighters[0].alive? && @fighters[0].class.name != 'Player'
      puts 'You lose'
    else
      puts 'You win'
    end

  end

  def choose_order
    puts 'Who will be first?'
    monster = Monster.new
    player = Player.new

    while @fighters.empty?
      command = Console.get_command

      case command.downcase
      when 'me'
        @fighters << player << monster
      when 'monster'
        @fighters << monster << player
      when 'quit'
        exit
      else 
        puts 'Invalid command'
        redo
      end
    end
  end
end