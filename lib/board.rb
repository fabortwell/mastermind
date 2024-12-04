class Board
  def initialize
    @guesses = []
    @feedback = []
  end

  def display
    @guesses.each_with_index do |guess, index|
      puts "Guess ##{index + 1}: #{guess.join(' ')} | Feedback: #{@feedback[index].join(' ')}"
    end
  end

  def add_guess(guess)
    @guesses << guess
  end

  def add_feedback(feedback)
    @feedback << feedback
  end
end
