class Game

  attr_reader :fighters

  def initialize
    @fighters= []
  end

  def start
    monster = Monster.new
    player = Player.new
    choose_order(monster, player)

    puts 'FIGHT!'

    result = Fighting.new(fighters).process
    if result.somebody_died?
      puts result.output
      return
    end

  end

  def choose_order(monster, player)

    while fighters.empty?
      command = Console.gets('first_move')

      case command
      when 'me'
        fighters << player << monster
      when 'monster'
        fighters << monster << player
      end
    end
  end
end
