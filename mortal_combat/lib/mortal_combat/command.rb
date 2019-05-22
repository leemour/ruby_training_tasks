# frozen_string_literal: true

module MortalCombat
  class Command
    NEW_GAMES     = %w[yes no].freeze
    FIRST_MOVES   = %w[player monster].freeze
    ATTACK_TYPES  = %w[normal special magic].freeze
    PROMPTS = {
      'new_game'    => "Do you want to start new game? #{NEW_GAMES}",
      'first_move'  => "Choose who moves first: #{FIRST_MOVES}",
      'attack_type' => "Choose attack type: #{ATTACK_TYPES}",
    }.freeze

    attr_reader :command

    def self.gets(command_name)
      puts PROMPTS[command_name]
      print ">> "
      command = new Kernel.gets.strip.downcase
      command.gets_until_valid(command_name)
    end

    def initialize(command)
      @command = command
      if command == 'quit'
        puts "Bye bye!"
        exit
      end
    end

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

