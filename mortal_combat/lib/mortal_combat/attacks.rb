# frozen_string_literal: true

module MortalCombat
  module Attacks
    def self.included(base)
      base.extend ClassMethods
    end

    def normal_attack(defender)
      attack_power
    end

    def special_attack(defender)
      attack_power * 2
    end

    def magic_attack(defender)
      attack_power + 100
    end

    def stun_attack(defender)
      defender.stunned!
      0
    end

    def block_attack(defender)
      health += attack_power * 2
      0
    end

    def stunned?
      @stunned == true
    end

    def stunned!
      @stunned = true
    end

    module ClassMethods
      def enable_attack(type:)
        return if attack[type.to_sym][:enabled] == true

        attacks[type.to_sym] = {count: 1, enabled: true}
      end
    end
  end
end
