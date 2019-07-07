# frozen_string_literal: true

module MortalCombat
  class Fighter
    attr_reader :health, :level, :attacks

    class << self
      attr_reader :level_up_hooks

      def add_level_up_hook(hook)
        level_up_hooks << hook
      end

      def inherited(base)
        base.class_eval do
          @level_up_hooks = []
        end
      end
    end

    def initialize(health:, attack_power:, level: 1)
      raise ArgumentError, "Health must be a positive integer" if health <= 0

      @health = health
      @attack_power = if attack_power.respond_to?(:sample)
        attack_power
      else
        attack_power.to_a
      end
      @attacks = {}
      @level = level
      @stunned = false
    end

    def attack(defender, type = nil)
      (@stunned = false) && return if stunned?

      type = determine_attack_type(type)
      damage = if type && respond_to?("#{type}_attack")
        send("#{type}_attack",defender)
      else
        normal_attack(defender)
      end

      binding.pry
      attacks[type.to_sym][:count] -= 1

      puts "#{klass} hits #{defender.klass} for #{damage} damage. "
      defender.take_damage(damage)
    end

    def take_damage(damage)
      self.health -= damage
      puts "#{klass} has #{health} health left"
    end

    def dead?
      self.health <= 0
    end

    def klass
      @klass ||= self.class.to_s.split("::").last
    end

    def move
      raise NotImplmentedError, "Implement '#{__method__}' method"
    end

    def increase_health
      health += 1
    end

    def increase_attack_power
      attack_power << attack_power.last + 1
    end

    def available_attacks
      attacks.each do |name, attributes|
        next if attributes[:enabled] == false || attributes[:count] == 0
        name.to_s
      end
    end

    private

    attr_writer :health, :level_up_hooks

    def attack_power
      @attack_power.sample
    end

    def determine_attack_type(type)
      if type.nil? && !attacks.values.all? { |attack| attack[:count].zero? }
        Command.gets("attack_type", prompt: available_attacks)
      end
    end

    def run_level_up_hooks
      self.class.level_up_hooks.each do |hook|
        next if hook[:level] != level || hook[:level] != "all"

        method(hook[:method]).call(hook[:options])
      end
    end
  end
end
