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

    def process
      fighter1.attack fighter2
      if fighter2.dead?
        @dead_fighter = fighter2
        @alive_fighter = fighter1
        return self
      end

      fighter2.attack fighter1
      if fighter2.dead?
        @dead_fighter = fighter1
        @alive_fighter = fighter2
      end
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
  end
end
