# # Tic Tac Toe
# # problem
# # Tic Tac Toe is a two-player game. There is a human and a computer, one marks the board with an x and the other marks the board with an o. There is a board with 9 squares. Each turn, one player marks one of the squares with their symbol. Then the next player marks a different square with their symbol. The game finishes when 1) a player has managed to mark three squares in a row (vertical, horizontal, or diagonal) or 2) all squares are full, and no one has marked three squares in a row (tie game).
# # Nouns and verbs
# # player
# # @symbol = 'X' or 'O'
# # def make_mark
# # human
# # computer
# # board has squares

# class Player
#   def initialize(symbol)
#     @symbol = symbol
#   end
# end

# class Human < Player
#   def make_mark
#     puts "Please choose a square to mark: ('X' or 'O')"
#     input = gets.chomp
#   end
# end

# class Computer < Player
#   def make_mark
#     board[rand(0..2)][rand(0..2)] = symbol
#   end
# end

# class Board
#   attr_accessor :squares

#   def initialize
#     @squares = [['', '', ''], ['', '', ''], ['', '', '']]
#     @squares = [[Square.new, Square.new, Square.new], [Square.new, Square.new, Square.new], [Square.new, Square.new, Square.new]]
#   end

#   def to_s
#     "  #{squares[0][0]}  |  #{squares[0][1]}  |  #{squares[0][2]}\n" \
#     "---------------\n" \
#     "  #{squares[1][0]}  |  #{squares[1][1]}  |  #{squares[2][1]}\n" \
#     "---------------\n" \
#     "  #{squares[2][0]}  |  #{squares[1][1]}  |  #{squares[2][1]}\n"
#   end
# end

# class Square
#   def initialize
#     @status = ''
#   end
# end

# class TTTGame
#   attr_accessor :human, :computer, :game_board

#   def initialize
#     @human = Human.new('X')
#     @computer = Computer.new('O')
#     @game_board = Board.new
#   end

#   def display_board
#     puts game_board
#   end
# end

# class Tic
#   def play
#     display_welcome
#     loop do
#       display_board
#       first_player_moves
#       break if winner? || board.full?

#       second_player_moves
#       break if winner? || board.full?
#     end
#     display_result
#     display_goodbye
#   end
# end

# game = TTTGame.new
# game.display_board
# game.computer.make_mark
# game.display_board

# spike code along

class Player
  attr_reader :mark

  def initialize; end
end

class Human < Player
  MARK = 'X'
  def initialize
    @mark = MARK
  end

  def choose
    loop do
      puts "Please choose a number 1-9"
      resp = gets.chomp.to_i
      return resp if (1..9).include?(resp)
      puts "Sorry, you must enter a number 1-9"
    end
  end
end

class Computer < Player
  MARK = 'O'
  def initialize
    @mark = MARK
  end

  def choose; end
end

class Board
  COMBOS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
            [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  attr_accessor :grid

  def initialize
    @grid = Array.new([Square.new, Square.new, Square.new,
                       Square.new, Square.new, Square.new,
                       Square.new, Square.new, Square.new])
  end

  def winning_mark
    [Computer::MARK, Human::MARK].select do |mk|
      Board::COMBOS.any? { |set| set.all? { |i| grid[i - 1].status == mk } }
    end
  end

  def winner?
    winning_mark.one?
  end

  def top_info
    "You are: #{Human::MARK}\n" \
      "Computer is: #{Computer::MARK}"
  end

  # def to_s
  #   grid.map do |row|
  #     "     |     |     \n" \
  #     "  #{row[0]}  |  #{row[1]}  |  #{row[2]}  \n" \
  #     "     |     |     \n" \
  #     "-----+-----+-----\n" \
  #   end
  # end

  def to_s
    "     |     |     \n" \
    "  #{grid[0]}  |  #{grid[1]}  |  #{grid[2]}  \n" \
    "     |     |     \n" \
    "-----+-----+-----\n" \
    "     |     |     \n" \
    "  #{grid[3]}  |  #{grid[4]}  |  #{grid[5]}  \n" \
    "     |     |     \n" \
    "-----+-----+-----\n" \
    "     |     |     \n" \
    "  #{grid[6]}  |  #{grid[7]}  |  #{grid[8]}  \n" \
    "     |     |     \n"
  end

  def empty_squares
    grid.map { |sq| sq.status == Square::INITIAL_MARKER }
  end

  def full?
    grid.none? { |square| square.status == Square::INITIAL_MARKER }
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :status

  def initialize
    @status = INITIAL_MARKER
  end

  def to_s
    status
  end

  def marked?
    square.status == INITIAL_MARKER
  end
end

class TTTGame
  attr_reader :board, :player1, :player2

  def initialize
    @player1 = Human.new
    @player2 = Computer.new
    @board = Board.new
  end

  def display_welcome_message_and_board
    system('clear')
    puts "Hello and welcome to Tic Tac Toe! Let's get started."
    puts board.top_info
    puts board
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!"
  end

  def display_board
    system('clear')
    puts board.top_info
    puts board
  end

  def first_player_moves
    loop do
      choice = player1.choose - 1
      if board.empty_squares[choice]
        board.grid[choice].status = player1.mark
        return
      else
        puts "Sorry, that square is already taken"
      end
    end
  end

  def second_player_moves
    loop do
      choice = rand(0..8)
      if board.grid[choice].status == Square::INITIAL_MARKER
        board.grid[choice].status = player2.mark
        break
      end
    end
  end

  def winner
    if board.winning_mark.include?(Human::MARK)
      "Player 1"
    else
      "Computer"
    end
  end

  def display_outcome_and_board
    system('clear')
    puts board
    puts board.full? ? "Tie game!" : "#{winner} wins!"
  end

  def play_again?
    loop do
      puts "Would you like to play again? Y or N"
      resp = gets.chomp.downcase
      return true if resp == 'y'
      return false if resp == 'n'
      puts "Sorry, you must choose Y or N."
    end
  end

  def turns
    loop do
      first_player_moves
      break if board.full? || board.winner?
      second_player_moves
      break if board.full? || board.winner?
      display_board
    end
  end

  def play
    display_welcome_message_and_board
    turns
    display_outcome_and_board
    play_again? ? TTTGame.new.play : display_goodbye_message
  end
end

TTTGame.new.play
