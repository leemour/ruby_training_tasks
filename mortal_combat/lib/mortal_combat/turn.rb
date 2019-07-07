# frozen_string_literal: true

module MortalCombat
  class Turn
    PROMTS = {
      "fight_continues" => "The fight is on"
    }.freeze

    attr_reader :fighter1, :fighter2, :dead_fighter

    def initialize(fighters)
      @fighter1, @fighter2 = fighters
    end

    def play
      attack(fighter1, fighter2)
      attack(fighter2, fighter1) unless fighter_died?
      self
    end

    def fighter_died?
      !!dead_fighter
    end

    def output
      if fighter_died?
        "#{@dead_fighter.klass} died. #{@alive_fighter.klass} wins!"
      else
        Turn::PROMTS["fight_continues"]
      end
    end

    private

    def attack(attacker, defender)
      attacker.attack defender
      if defender.dead?
        @dead_fighter = defender
        @alive_fighter = attacker
      end
    end
  end
end
