# frozen_string_literal: true

lib = File.expand_path(__dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "mortal_combat/version"
require "mortal_combat/command"
require "mortal_combat/round"
require "mortal_combat/game"
require "mortal_combat/turn"
require "mortal_combat/attacks"
require "mortal_combat/fighter"
require "mortal_combat/player"
require "mortal_combat/monster"

module MortalCombat
  class NotImplementedError < StandardError; end
end
