require_relative "player"
require_relative "monster"
require_relative "console"

class Game

  def initialize()
    @monster = Monster.new()
    @player = Player.new()
  end

  def start()
    choose_order()

    puts 'FIGHT!'

    if !@is_player_first
      @monster.hit(@player)
    end

    while @monster.alive? && @player.alive? do

      if @player.alive?
        command = Console.get_command()

        case command
        when /\Ahit\z/i
          @player.hit(@monster)
        when /\Asuperhit\z/i
          if @player.has_superhits? 
            @player.superhit(@monster)
          else 
            puts 'You already used superhit!'
            redo
          end
        when /\Aquit\z/i
          exit
        else 
          puts 'Invalid command'
          redo
        end
      end

      if @monster.alive?
        @monster.hit(@player) 
      end
    end

    if @monster.alive?
      puts 'You lose'
    else
      puts 'You win'
    end

  end

  def choose_order()
    puts 'Who will be first?'

    while @is_player_first.nil?
      command = Console.get_command()

      case command
      when /\Ame\z/i
        @is_player_first = true
      when /\Amonster\z/i
        @is_player_first = false
      when /\Aquit\z/i
        exit
      else 
        puts 'Invalid command'
        redo
      end
    end
  end

end