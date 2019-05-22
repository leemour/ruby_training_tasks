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
      command = new Kernel.gets.strip.downcase
      command.public_send(command_name)
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
      valid_commands = Command.const_get("#{command_name}s".upcase)
      unless valid_commands.include? command
        puts "Invalid command. Valid commands are: #{valid_commands}"
        return Command.gets(command_name)
      end
      command
    end
  end
end

