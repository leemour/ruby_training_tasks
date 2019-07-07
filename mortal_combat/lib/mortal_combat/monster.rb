# frozen_string_literal: true

module MortalCombat
  class Monster < Fighter
    include Attacks

    add_level_up_hook level: 'all', method: :increase_health
    add_level_up_hook level: 'all', method: :increase_attack_power
    add_level_up_hook level: 3, method: :enable_attack, options: {type: "magic"}
    add_level_up_hook level: 4, method: :enable_attack, options: {type: "stun"}
    add_level_up_hook level: 5, method: :enable_attack, options: {type: "block"}

    def initialize(health:, attack_power:, level: 1)
      super
      @attacks = Game::FIGHER_DEFAULTS[:monster][:attacks]
    end

    private

    def determine_attack_type(type)
      available_attacks.sample
    end
  end
end
