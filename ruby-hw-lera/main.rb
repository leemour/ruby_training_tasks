require_relative "game"
require_relative "console"
require_relative "character"
require_relative "player"
require_relative "monster"

loop do
  game = Game.new
  game.start


  puts 'Do you want play again?'
  loop do 
    command = Console.get_command

    case command.downcase
    when 'yes'
      break
    when 'no'
      exit
    else 
      puts 'Invalid command'
      redo
    end
  end
end