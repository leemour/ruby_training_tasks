require_relative "console"
require_relative "game"
require_relative "fighting"
require_relative "character"
require_relative "player"
require_relative "monster"

loop do
  game = Game.new
  game.start

  command = Console.gets('new_game')
  if command == 'no'
    puts 'さようなら =^_^='
    break;
  end
end
