class Move
  include Comparable

  VALUES = { 'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper' }

  attr_accessor :hand

  def initialize(hand)
    @hand = hand
  end

  def <=>(other)
    if VALUES[hand] == other.hand
      1
    elsif VALUES[other.hand] == hand
      -1
    else
      0
    end
  end

  def to_s
    hand
  end
end

class Player
  attr_reader :hand
  attr_accessor :name

  def initialize
    set_name
  end

  private

  attr_writer :hand
end

class Human < Player
  def set_name
    puts "Please share your name"
    self.name = gets.chomp
  end

  def choose
    loop do
      puts 'Please choose your move.'
      choice = gets.chomp.downcase
      if Move::VALUES.keys.include?(choice)
        self.hand = Move.new(choice)
        break
      end
    end
  end
end

class Computer < Player
  def set_name
    self.name = ['Siri', 'Hal', "Mother", 'Sonny', 'R2D2'].sample
  end

  def choose
    self.hand = Move.new(Move::VALUES.keys.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer, :repeat

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to RPS #{human.name.capitalize}. Let's get started!"
  end

  def display_goodbye_message
    puts "Thanks for playing RPS. Have a rockin' day."
  end

  def determine_winner
    return false if human.hand == computer.hand
    human.hand > computer.hand ? [human, computer] : [computer, human]
  end

  def display_winner
    unless determine_winner
      puts "Tie game!"
      return
    end
    winner, loser = determine_winner
    puts "#{winner.name} chose #{winner.hand} and WINS!!"
    puts "#{loser.name} chose #{loser.hand} and LOSES"
  end

  def play_again?
    loop do
      puts "Want to play again?"
      repeat = gets.chomp.downcase
      return true if repeat == 'yes'
      return false if repeat == 'no'
      puts "Sorry, please re-enter"
    end
  end

  def play
    loop do
      display_welcome_message
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
