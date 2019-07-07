# frozen_string_literal: true

module MortalCombat
  class Round
    WIN_EXPERIENCE = 10
    LOOSE_EXPERIENCE = 8

    attr_reader :output, :player, :monster, :dead_fighter

    def initialize(turn)
      @turn = turn.output
      @dead_fighter = turn.dead_fighter
      [turn.fighter1, turn.fighter2].each do |fighter|
        @player = fighter if fighter.is_a? Player
        @monster = fighter if fighter.is_a? Monster
      end
    end

    def complete
      puts output
      if dead_fighter == monster
        player_wins
      else
        player_looses
      end
      normalize_monster_level
    end

    private

    def player_wins
      player.experience += WIN_EXPERIENCE
      puts "Player wins!"
      puts "Player gained #{WIN_EXPERIENCE} experience. #{player.experience} "\
        "total. Current level is #{player.level}"
    end

    def player_looses
      player.experience -= WIN_EXPERIENCE
      puts "Player looses!"
      puts "Player lost #{WIN_EXPERIENCE} experience. #{player.experience} "\
        "total. Current level is #{player.level}"
    end

    def normalize_monster_level
      monster.level = player.level if player.level != monster.level
    end
  end
end
