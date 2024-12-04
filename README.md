
---

# Mastermind Command Line Game

## Overview

This project is a command-line Mastermind game built using the Ruby programming language. The game allows a human player to either guess the computer's randomly generated secret code or create a secret code for the computer to guess. The human player has 12 turns to guess the secret code, with feedback provided after each guess.

### Game Design
1. **Classes**:
   - `Game`: Manages the overall game flow.
   - `Board`: Manages the current state of the guesses and feedback.
   - `Player`: Manages player actions and inputs.
   - `Code`: Manages the creation and evaluation of the secret code.

2. **Instance Variables**:
   - **Game**: `@code`, `@board`, `@player`.
   - **Board**: `@guesses`, `@feedback`.
   - **Player**: `@name`.
   - **Code**: `@secret_code`.

3. **Methods**:
   - **Game**: `initialize`, `play`, `setup`, `provide_feedback`, `end_game`.
   - **Board**: `initialize`, `display`, `add_guess`, `add_feedback`.
   - **Player**: `initialize`, `make_guess`, `choose_role`, `set_code`.
   - **Code**: `initialize`, `generate`, `evaluate_guess`.

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/mastermind.git
   cd mastermind
   ```

2. **Install Ruby**: Ensure Ruby is installed on your system. You can download it from [ruby-lang.org](https://www.ruby-lang.org/en/downloads/).

3. **Run the Game**:
   ```bash
   ruby game.rb
   ```

## Usage

1. When you run the game, the player chooses to either be the code maker or guesser.
2. If the player is the guesser, the computer generates a random code. The player has 12 turns to guess the code.
3. If the player is the code maker, they set the secret code and the computer attempts to guess it.
4. After each guess, feedback is provided indicating how many colors are correct and in the correct position (B) or correct but in the wrong position (W).
5. The game continues until the code is guessed correctly or the turns run out.

## Code Structure

### game.rb

Manages the game flow and player turns.

```ruby
require_relative 'board'
require_relative 'player'
require_relative 'code'

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
```

### board.rb

Manages the game state, including displaying the board, adding guesses, and feedback.

```ruby
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
```

### player.rb

Handles player input and role selection.

```ruby
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
```

### code.rb

Generates and evaluates the secret code.

```ruby
class Code
  attr_accessor :secret_code
  COLORS = %w[R G B Y O P]

  def initialize
    @secret_code = []
  end

  def generate
    @secret_code = Array.new(4) { COLORS.sample }
  end

  def evaluate_guess(guess)
    feedback = []
    temp_code = @secret_code.clone

    guess.each_with_index do |color, index|
      if color == temp_code[index]
        feedback << 'B'
        temp_code[index] = nil
      elsif temp_code.include?(color)
        feedback << 'W'
        temp_code[temp_code.index(color)] = nil
      end
    end

    feedback.sort.reverse
  end
end
```
