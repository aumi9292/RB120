require 'pry'

class Decision
  attr_accessor :validated

  def initialize(question, valid = { y: true, n: false })
    @question = question
    puts question
    @valid = valid
    @response = gets.chomp.downcase.to_sym
    @error_message = "Sorry, invalid response. Try again."
    @clear_screen = system('clear')
    @validated = valid.instance_of?(Hash) ? validate_response : validate_range
  end

  private

  attr_accessor :response, :valid, :error_message

  def validate_response
    return valid[response] if valid.key?(response)
    puts error_message
    Decision.new(@question, @valid).validated
  end

  def validate_range
    return response.to_s.capitalize if valid.cover?(response.to_s)
    puts error_message
    Decision.new(@question, @valid).validated
  end
end

class Player
  attr_accessor :name, :score

  MARKS = ['X', 'O']

  def initialize
    @score = 0
  end

  def add_win
    self.score += 1
  end
end

class Human < Player
  @@mark = nil

  def initialize
    @name = nil
    super
  end

  def self.mark
    @@mark
  end

  def self.select_first_mark
    q = "Please choose X or O (X goes first, O goes second): "
    @@mark = Decision.new(q, { x: MARKS[0], o: MARKS[1] }).validated
  end

  def set_name
    self.name = Decision.new("Please write your name: ", ('a'..'z')).validated
  end
end

class Computer < Player
  @@mark = nil

  def initialize
    @name = ['Eva', 'Ava', 'WALL-E', 'Samantha', 'Sonny'].sample
    super
  end

  def self.select_second_mark
    @@mark = MARKS.reject { |mark| mark == Human.mark }.first
  end

  def self.mark
    @@mark
  end
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

  def reset
    self.grid = grid.map { Square.new }
  end

  def to_s
    row1 + row2 + row3
  end

  def [](index)
    grid[index - 1]
  end

  def []=(index, value)
    grid[index - 1].status = value
  end

  def empty_squares
    grid.map(&:unmarked?)
  end

  def empty_squares_list
    empty_squares.map.with_index { |sq, i| i + 1 if sq }.compact
  end

  def empty_square_numbers_string
    arr = empty_squares_list.map(&:to_s)
    return arr.first if arr.length == 1
    return arr.join(' or ') if arr.length == 2
    arr[0...-1].join(', ') << ' or ' << arr[-1]
  end

  def full?
    grid.none?(&:unmarked?)
  end

  private

  def row1
    "     |     |     \n" \
    "  #{grid[0]}  |  #{grid[1]}  |  #{grid[2]}  \n" \
    "     |     |     \n" \
    "-----+-----+-----\n" \
  end

  def row2
    "     |     |     \n" \
    "  #{grid[3]}  |  #{grid[4]}  |  #{grid[5]}  \n" \
    "     |     |     \n" \
    "-----+-----+-----\n" \
  end

  def row3
    "     |     |     \n" \
    "  #{grid[6]}  |  #{grid[7]}  |  #{grid[8]}  \n" \
    "     |     |     \n"
  end
end

class Square
  INITIAL_MARK = ' '

  attr_accessor :status

  def initialize
    @status = INITIAL_MARK
  end

  def h_marked?
    status == Human.mark
  end

  def c_marked?
    status == Computer.mark
  end

  def unmarked?
    status == INITIAL_MARK
  end

  def marked?
    status != INITIAL_MARK
  end

  private

  def to_s
    status
  end
end

module Movable
  def move(party)
    party.instance_of?(Human) ? human_move : computer_move
  end

  private

  def computer_move
    opps, threats = select_open_targets(evaluate_board)
    pressing?(opps, threats) ? handle : easy_choice
  end

  def human_move
    loop do
      puts "Please choose a number: #{board.empty_square_numbers_string}"
      choice = gets.chomp
      if invalid_input?(choice)
        puts "Sorry, that is not a valid square"
      else
        board[choice.to_i] = Human.mark
        break
      end
    end
  end

  def invalid_input?(choice)
    num = choice.to_i
    num < 1 || board[num].marked? || choice.length > 1
  end

  def evaluate_opportunities
    o = Board::COMBOS.select { |set| set.count { |i| board[i].c_marked? } == 2 }
    eliminate_duplicates(o)
  end

  def evaluate_threats
    t = Board::COMBOS.select { |set| set.count { |i| board[i].h_marked? } == 2 }
    eliminate_duplicates(t)
  end

  def eliminate_duplicates(squares)
    squares.flatten.uniq
  end

  def evaluate_board
    [evaluate_opportunities, evaluate_threats]
  end

  def select_open_targets(opps_and_threats)
    opps_and_threats.each do |positions|
      positions.select! { |i| board[i].unmarked? }
    end
    opps_and_threats
  end

  def choose(target)
    board[target] = Computer.mark
  end

  def handle
    opps, threats = select_open_targets(evaluate_board)
    choose !opps.empty? ? (opps.first) : (threats.first)
  end

  def pressing?(opps, threats)
    !opps.empty? || !threats.empty?
  end

  def random_choice
    board.empty_squares_list.sample
  end

  def easy_choice
    choose board[5].unmarked? ? (5) : (random_choice)
  end
end

module Displayable
  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!"
  end

  def display_outcome_and_board
    display_board
    puts winner? ? "\n#{winner_name} wins!" : "Tie game!"
    display_score
  end

  def display_tourn_goodbye_message
    system('clear')
    puts tourn_message
  end

  def welcome
    system('clear')
    puts "Hello and welcome to Tic Tac Toe! Let's get started."
    set_name_and_marks
  end

  def display_board
    system('clear')
    puts top_info
    puts board
  end

  private

  def display_score
    puts "\n**** Total Score ****"
    puts "#{player1.name}: #{player1.score}"
    puts "#{player2.name}: #{player2.score}"
    sleep(1.5)
  end

  def tourn_message
    m = "#{grand_winner} is the grand winner! Thanks for playing. Goodbye."

    "\n#{'*' * m.length}\n" \
     "#{m}" \
    "\n#{'*' * m.length}"
  end

  def top_info
    "#{player1.name} is: #{player1.class.mark}\n" \
      "#{player2.name} is: #{player2.class.mark}"
  end
end

class TTTGame
  include Movable, Displayable

  attr_accessor :player1, :player2

  WIN_SCORE = 5

  def initialize
    @players = [Human.new, Computer.new]
    @player1 = nil
    @player2 = nil
    @board = Board.new
  end

  def initiate_sequence
    welcome
    play_tournament?
  end

  private

  attr_reader :players, :board

  def set_name_and_marks
    players.select { |ob| ob.instance_of?(Human) }.first.set_name
    set_player_marks
    self.player2, self.player1 = players.sort_by { |ob| ob.class.mark }
  end

  def set_player_marks
    Human.select_first_mark
    Computer.select_second_mark
  end

  def winning_mark
    Player::MARKS.select do |mk|
      Board::COMBOS.any? { |set| set.all? { |i| board[i].status == mk } }
    end
  end

  def winner?
    !winning_mark.empty?
  end

  def winner_name
    mark = winning_mark.first
    players.select { |player| player.class.mark == mark }.first.name
  end

  def update_winner(winner)
    players.each { |player| player.add_win if player.name == winner }
  end

  def play_again?
    Decision.new("\nWould you like to play again? Y or N").validated
  end

  def move_and_reveal(party)
    move(party)
    display_board
  end

  def turns
    loop do
      move_and_reveal(player1)
      break if board.full? || winner?
      move_and_reveal(player2)
      break if board.full? || winner?
    end
    update_winner(winner_name) if winner?
  end

  def valid_tournament_choice
    q = "Want to play a tournament? Best of #{WIN_SCORE} wins. Y or N"
    Decision.new(q).validated
  end

  def play_tournament?
    valid_tournament_choice ? play_tourn : play_solo
  end

  def play_solo
    loop do
      display_board
      turns
      display_outcome_and_board
      play_again? ? board.reset : break
    end
    display_goodbye_message
  end

  def grand_winner
    player1.score == WIN_SCORE ? player1.name : player2.name
  end

  def tourn_round_end
    display_outcome_and_board
    board.reset
  end

  def grand_winner?
    players.map(&:score).include?(WIN_SCORE)
  end

  def play_tourn
    loop do
      display_board
      turns
      tourn_round_end
      break if grand_winner?
    end
    display_tourn_goodbye_message
  end
end

TTTGame.new.initiate_sequence
