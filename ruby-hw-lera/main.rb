require_relative "game"
require_relative "console"

loop do
  game = Game.new()
  game.start()


  puts 'Do you want play again?'
  loop do 
    command = Console.get_command()

    case command
    when /\Ayes\z/i
      break
    when /\Ano\z/i
      exit
    else 
      puts 'Invalid command'
      redo
    end
  end
end