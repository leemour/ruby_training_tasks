# frozen_string_literal: true

module MortalCombat
  class Player < MortalCombat::Fighter
    def initialize(health:, attack_power:)
      super
      @attacks = {
        special: 1,
        magic:   2
      }
    end

    def special_attack_power
      attack_power * 2
    end

    def magic_attack_power
      attack_power + 100
    end
  end
end
