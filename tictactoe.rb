class TicTacToe
  attr_accessor :game_end

  def initialize(row_size, col_size)
    @board = Array.new(row_size){Array.new(col_size)}
    @p1_turn = true  # p1 goes first as 'X'
    @game_end = false
  end

  def play_game
    @move_count = 0
    while @game_end != true && @move_count < 9
      self.display_board
      puts "Please choose an empty location: "
      print @p1_turn ? "X turn:  " : "O turn: "
      location = gets.chomp
      self.location_check(location)
      @move_count += 1
    end
    puts "Tie Game!" if @move_count == 9
    exit 1
  end

  def game_over
    @game_end = true
    # @p1_turn switches after each move. X wins here when p1_turn is false.
    puts @p1_turn ? "O Wins!!" : "X Wins!!"
    puts "Game Over!!!"
  end

  def display_board
    @board.each_with_index do |row, row_idx|
      @board.each_with_index do |col, col_idx|
        print @board[row_idx][col_idx].nil? ? "[ ]" : "[#{@board[row_idx][col_idx]}]"
      end
      print "\n"
    end
    2.times { print "\n" }
  end

  def location_check(location)
    location = location.split(",")
    row = location[0].to_i
    col = location[1].to_i

    if row > @board.size-1 || col > @board.size-1 || @board[row][col] != nil
      puts "Can't move there!"
      puts "Please choose an empty location: "
      location = gets.chomp
      self.location_check(location)
    else
      self.player_move(row, col)
    end
  end

  def player_move(row, col)
    if @p1_turn
      @board[row][col] = "X"
      @p1_turn = false
    else
      @board[row][col] = "O"
      @p1_turn = true
    end
    self.board_check
  end

  def board_check
    # Winning conditions
    # Horizontal
    for i in  0..@board.size-1
      mismatch = false
      for j in 0..@board[i].size-2
        if @board[i][j] != @board[i][j+1] || @board[i][j].nil?
          mismatch = true
          break
        end
      end
      return self.game_over if !mismatch
    end

    # Vertical
    for i in 0..@board.size-1
      mismatch = false
      for j in 0..@board.size-2
        if @board[j][i] != @board[j+1][i] || @board[j][i].nil?
          mismatch = true
          break
        end
      end
      return self.game_over if !mismatch
    end

    # TLBR and BLTR diagonals done instead of hard coding to account for
    # board sizes greater than 3x3
    # Diagonal: Top Left -> Bottom Right
    for i in 0..@board.size-2
      mismatch_TLBR = false
      if @board[i][i] != @board[i+1][i+1] || @board[i][i].nil?
        mismatch_TLBR = true
        break
      end
    end
    return self.game_over if !mismatch_TLBR

    # Diagonal: Bottom Left -> Top Right
    for i in 0..@board.size-2
      mismatch_BLTR = false
      row = @board.size - 1 - i
      if @board[row][i].nil? || @board[row][i] != @board[row][i+1]
        mismatch_BLTR = true
        break
      end
    end
    return self.game_over if !mismatch_BLTR
  end

end

test = TicTacToe.new(3,3)
test.play_game
