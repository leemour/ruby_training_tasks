module Console

  def self.get_command
    print '>>'
    command = gets.strip.split(/\s/).first
  end

end