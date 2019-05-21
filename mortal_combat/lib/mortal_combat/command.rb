# frozen_string_literal: true

module MortalCombat
  class Command
    NEW_GAMES     = %w[yes no].freeze
    FIRST_MOVES   = %w[player monster].freeze
    ATTACK_TYPES  = %w[normal special].freeze
    PROMPTS = {
      'new_game'    => "Do you want to start new game? (yes/no)",
      'first_move'  => "Choose who moves first: 'player' or 'monster'",
      'attack_type' => "Choose attack type: 'normal' or 'special'",
    }.freeze

    attr_reader :command

    def self.gets(command_name)
      puts PROMPTS[command_name]
      print ">> "
      new Kernel.gets.strip.downcase
    end

    %w[new_game first_move attack_type].each do |command_name|
      define_method command_name do
        gets_until_valid(command_name)
      end
    end

    def initialize(command)
      @command = command
      if command == 'quit'
        puts "Bye bye!"
        exit
      end
    end

    private

    def gets_until_valid(command_name)
      unless Command.const_get("#{command_name}s".upcase).include? command
        return Command.gets.public_send(command_name)
      end
      command_name
    end
  end
end

