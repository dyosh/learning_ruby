################################################################################
#                             Gameplay and Rules
################################################################################
# => A decoding board, with a shield at one end covering a row of four large
#    holes, and twelve (or ten, or eight, or six) additional rows containing
#    four large holes next to a set of four small holes.
# => Code pegs of six different colors, with round heads, which will be placed
#    in the large holes on the board.
# => White - one right in the wrong spot
# => Red   - one right in the right spot
# => 4 positions, 6 colors
################################################################################
class Mastermind

  def initialize
    @player_is_breaker
    @player_guess = []
    @code_sequence = []
    @code_hash = Hash.new(0)
    @guess_hash = Hash.new(0)
    @COLORS = ["blue", "green", "white", "orange", "purple", "yellow"]
    self.start_game
  end

  def start_game
    self.maker_or_breaker
    if @player_is_breaker
      self.random_sequence
      self.guess_code(true) # true passed to indicate player is the breaker
    else
      self.player_sequence
      self.guess_code(false) # false passed to indicate computer is the breaker
    end
  end

  def maker_or_breaker
    puts "Play as the codebreaker or codemaker?"
    user_choice = gets.chomp
    user_choice == "codebreaker" ? @player_is_breaker = true : @player_is_breaker = false
  end

  def player_sequence
    puts "Enter a sequence of colors seperated by spaces."
    puts "Possible Colors: #{@COLORS}"
    @code_sequence = gets.chomp.split(" ")
    puts @code_sequence
  end

  def random_sequence
    (0..3).each_with_index do |color, index|
      color = @COLORS[Random.rand(6)]
      @code_sequence << color
      @code_hash[color] += 1
    end
    puts @code_hash
    print @code_sequence
    print "\n\n"
  end

  def code_check
    feedback = { :white => 0, :red => 0 }
    # find how many colors in the guess are correct
    @guess_hash.each do |color, count|
      if @code_hash[color] != nil
        if count <= @code_hash[color]
          feedback[:white] += count
        else
          feedback[:white] += @code_hash[color]
        end
      end
    end

    # Find how many positions are correct. If a correct position is found
    # we swap a white feedback peg for a red one.
    @code_sequence.each_with_index do |color, index|
      if @player_guess[index] == color
        feedback[:white] -= 1
        feedback[:red] += 1
      end
    end
    # Game over if all pegs are matched (4 red)
    puts "WIN!" if feedback[:red] == 4
    puts feedback
    @guess_hash.clear
    print "\n\n"
  end

  def guess_code(player_guessing)
    if player_guessing == true
      guess_count = 0
      while guess_count < 6
        puts "Choose 4 colors seperated by spaces."
        puts "Color Choices: #{@COLORS}"
        @player_guess = gets.chomp.split(" ")
        @player_guess.each { |color| @guess_hash[color] += 1 }
        self.code_check
        guess_count += 1
      end
    else
      guess_count = 0
      while guess_count < 6
        @player_guess = []
        (0..3).each_with_index do |color, index|
          color = @COLORS[Random.rand(6)]
          @player_guess << color
          @guess_hash[color] += 1
        end
        puts "CPU Guess: #{@player_guess}"
        self.code_check
        guess_count += 1
      end
    end
  end

end

game = Mastermind.new
