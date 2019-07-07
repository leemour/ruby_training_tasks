# frozen_string_literal: true

module MortalCombat
  class Round
    WIN_EXPERIENCE = 10
    LOOSE_EXPERIENCE = 8

    attr_reader :output, :player, :monster

    def initialize(turn)
      @output = turn.output
      [turn.fighter1, turn.fighter2].each do |fighter|
        @player = fighter if fighter.is_a? Player
        @monster = fighter if fighter.is_a? Monster
      end
    end

    def complete
      puts output
      if turn.dead_fighter == monster
        player_wins
      else
        player_looses
      end
    end

    private

    def player_wins
      player.experience += WIN_EXPERIENCE
      normalize_monster_level
    end

    def player_looses
      player.experience -= WIN_EXPERIENCE
      normalize_monster_level
    end

    def normalize_monster_level
      monster.level = player.level if player.level != monster.level
    end
  end
end
