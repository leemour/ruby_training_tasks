# frozen_string_literal: true

module MortalCombat
  class Fighter
    attr_reader :health

    def initialize(health:, attack_power:)
      raise ArgumentError.new("Health must be positive integer") if health <= 0
      @health = health
      @attack_power = attack_power.respond_to?(:sample) ? attack_power : attack_power.to_a
      @attacks = {}
    end

    def attack(opponent, type = nil)
      type = determine_attack_type(type)

      damage = if type && respond_to?("#{type}_attack_power")
        send("#{type}_attack_power")
      else
        attack_power
      end

      puts "#{klass} hits #{opponent.klass} for #{damage} damage. "
      opponent.take_damage(damage)
    end

    def take_damage(damage)
      self.health -= damage
      puts "#{klass} has #{health} health left"
    end

    def dead?
      self.health <= 0
    end

    def klass
      @klass ||= self.class.to_s.split('::').last
    end

    def move
      raise NotImplmentedError, "Implement '#{__method__}' method"
    end

    private

    attr_writer :health

    def attack_power
      @attack_power.sample
    end

    def determine_attack_type(type)
      if type.nil? && !@attacks.empty?
        type = Command.gets('attack_type')
        @attacks[type.to_sym] -= 1
      end
      type
    end
  end
end
