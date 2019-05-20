module Console

  def self.get_command()
    print '>>'
    input = gets.chomp
    command = input.split(/\s/).first
  end

end