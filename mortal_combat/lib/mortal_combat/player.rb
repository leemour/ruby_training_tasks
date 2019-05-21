# frozen_string_literal: true

class MortalCombat::Player < MortalCombat::Fighter
  def initialize(health:, attack_power:)
    super
    @special_attack = 1
  end

  def special_attack_power
    attack_power * 2
  end
end
