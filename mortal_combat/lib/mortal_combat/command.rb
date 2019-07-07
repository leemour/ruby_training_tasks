# frozen_string_literal: true

module MortalCombat
  class Command
    VALID_INPUT = {
      "attack_type" => %w[normal special magic],
      "first_move"  => %w[player monster],
      "increase_attribute" => %w[health attack_power],
      "new_game"    => %w[yes no],
      "new_round"   => %w[yes no],
    }.freeze
    PROMPTS = {
      "attack_type" => "Choose attack type: %{prompt}",
      "exit"        => "Bye-bye!",
      "first_move"  => "Choose who moves first: #{VALID_INPUT["first_move"]}",
      "increase_attribute"  => "Choose attribute to increase: "\
        "#{VALID_INPUT["increase_attribute"]}",
      "new_game"    => "Start a new game? #{VALID_INPUT["new_game"]}",
      "new_round"   => "Start a new round? #{VALID_INPUT["new_round"]}"
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
