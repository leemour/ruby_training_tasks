# frozen_string_literal: true

module MortalCombat
  class Player < Fighter
    include Attacks

    attr_reader :experience

    add_level_up_hook level: 2, method: :enable_attack, options: {type: "magic"}
    add_level_up_hook level: 3, method: :enable_attack, options: {type: "stun"}
    add_level_up_hook level: 4, method: :enable_attack, options: {type: "block"}

    def initialize(health:, attack_power:, level: 1)
      super
      @attacks = {
        normal:  {count: -1, enabled: true},
        special: {count: 1,  enabled: true},
        magic:   {count: 0,  enabled: false},
        stun:    {count: 0,  enabled: false},
        block:   {count: 0,  enabled: false},
      }
      @experience = level == 1 ? 0 : experience_for_level(level)
    end

    def experience=(value)
      @experience = value
      if ready_for_level_up?
        self.level += 1
        run_level_up_hooks
      end
    end

    def ready_for_level_up?
      experience >= experience_for_level(level + 1)
    end

    private

    def experience_for_level(level_number)
      10 * (level_number ** 2) - (10 * level_number)
    end
  end
end
