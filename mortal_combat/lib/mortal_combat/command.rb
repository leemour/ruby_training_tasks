# frozen_string_literal: true

module MortalCombat
  class Command
    VALID_INPUT = {
      "new_game"    => %w[yes no],
      "first_move"  => %w[player monster],
      "attack_type" => %w[normal special magic]
    }.freeze
    PROMPTS = {
      "new_game"    => "Start a new game? #{VALID_INPUT["new_game"]}",
      "first_move"  => "Choose who moves first: #{VALID_INPUT["first_move"]}",
      "attack_type" => "Choose attack type: %{prompt}",
      "exit"        => "Bye-bye!"
    }.freeze

    attr_reader :command

    def self.gets(command_name, prompt: "")
      unless VALID_INPUT.keys.include? command_name
        raise InvalidCommand, "Command #{command_name} doesn't exist"
      end

      puts PROMPTS[command_name].sub("%{prompt}", prompt.to_s)
      print ">> "
      command = new Kernel.gets.strip.downcase
      command.gets_until_valid(command_name)
    end

    def initialize(command)
      @command = command
      puts(Command::PROMPTS["exit"]) && exit if command == "quit"
    end

    def gets_until_valid(command_name)
      valid_commands = Command::VALID_INPUT[command_name]
      unless valid_commands.include? command
        puts "Invalid command #{command}. Valid commands are: #{valid_commands}"
        return Command.gets(command_name)
      end
      command
    end
  end
end
