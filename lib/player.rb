class Player
  def initialize
    @name = "Player"
  end

  def choose_role
    puts "Do you want to be the code maker or guesser? (Enter 'maker' or 'guesser')"
    gets.chomp.downcase
  end

  def make_guess
    puts "Enter your guess (e.g., 'R G B Y'):"
    gets.chomp.split
  end

  def set_code
    puts "Set your secret code (e.g., 'R G B Y'):"
    gets.chomp.split
  end
end
