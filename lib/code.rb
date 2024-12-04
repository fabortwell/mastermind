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

