# frozen_string_literal: true

module MortalCombat
  class Game
    attr_reader :player, :monster

    def self.setup
      puts <<~WELL
        ============================================
          Welcome to Mortal Combat. This is a turn-based single player game
          where you will be fighting with a monster
        ============================================
      WELL
      loop do
        if Command.gets('new_game') != 'yes'
          puts "Bye bye!"
          return
        end
        game = new
        game.start
        game.end
      end
    end

    def initialize
      @player  = Player.new(health: 30, attack_power: (1..6))
      @monster = Monster.new(health: 30, attack_power: (2..5))
    end

    def start
      fighters = fighters_ordered_by_move

      loop do
        result = Turn.new(fighters).process
        if result.fighter_died?
          puts result.output
          return
        end
      end
    end

    def end
      puts "The game is over"
    end

    private

    def fighters_ordered_by_move
      if Command.gets('first_move') == 'player'
        [player, monster]
      else
        [monster, player]
      end
    end
  end
end
