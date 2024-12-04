require_relative 'lib/board.rb'
require_relative 'lib/player.rb'
require_relative 'lib/code.rb'

class Game
  def initialize
    @code = Code.new
    @board = Board.new
    @player = Player.new
  end

  def play
    role = @player.choose_role
    setup(role)
    turns = 12

    turns.times do |turn|
      puts "\nTurn #{turn + 1}"
      guess = @player.make_guess
      feedback = @code.evaluate_guess(guess)
      @board.add_guess(guess)
      @board.add_feedback(feedback)
      @board.display

      if feedback == ['B', 'B', 'B', 'B']
        puts "Congratulations! You've cracked the code!"
        return
      end
    end

    puts "Sorry, you've run out of turns. The code was #{@code.secret_code.join(' ')}."
  end

  private

  def setup(role)
    if role == 'guesser'
      @code.generate
    else
      @code.secret_code = @player.set_code
    end
  end
end

game = Game.new
game.play
