# frozen_string_literal: true

module MortalCombat
  class Game
    PROMPTS = {
      "end_round" => "The round is over",
      "game_over" => "The game is over",
      "welcome"   => <<~WELL
        ============================================
          Welcome to Mortal Combat. This is a turn-based single player game
          where you will be fighting with a monster
        ============================================
      WELL
    }.freeze
    FIGHER_DEFAULTS = {
      player: {
        health: 30,
        attacks: {
          normal:  {count: -1, enabled: true},
          special: {count: 1,  enabled: true},
          magic:   {count: 0,  enabled: false},
          stun:    {count: 0,  enabled: false},
          block:   {count: 0,  enabled: false},
        }
      },
      monster: {
        health: 30,
        attacks: {
          normal:  {count: -1, enabled: true},
          special: {count: 0,  enabled: false},
          magic:   {count: 0,  enabled: false},
          stun:    {count: 0,  enabled: false},
          block:   {count: 0,  enabled: false},
        }
      }
    }.freeze

    attr_reader :player, :monster

    def self.setup
      puts PROMPTS["welcome"]
      loop do
        if Command.gets("new_game") != "yes"
          puts Command::PROMPTS["exit"]
          return
        end
        game = new
        game.start
        game.end
      end
    end

    def initialize
      @player  = Player.new(
        health: FIGHER_DEFAULTS[:player][:health],
        attack_power: (1..6)
      )
      @monster = Monster.new(
        health: FIGHER_DEFAULTS[:monster][:health],
        attack_power: (2..5)
      )
    end

    def start
      fighters = fighters_ordered_by_move

      loop do
        result = Turn.new(fighters).play
        if result.fighter_died?
          Round.new(result).complete
          if Command.gets("new_round") != "yes"
            puts Command::PROMPTS["end_round"]
            return
          else
            reset_fighters
          end
        end
      end
    end

    def end
      puts Game::PROMPTS["game_over"]
    end

    private

    def fighters_ordered_by_move
      if Command.gets("first_move") == "player"
        [player, monster]
      else
        [monster, player]
      end
    end

    def reset_fighers
      [player, monster].each do |fighter|
        player.reset_health
        player.reset_attacks
      end
    end
  end
end
