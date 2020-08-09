require 'pry'

module Displayable
  def welcome
    puts "Welcome to RPS #{human.name}. Let's get started!"
  end

  def goodbye
    puts "Thanks for playing RPS. Have a rockin' day."
  end

  def round_outcome
    return puts("All chose #{human.hand}. Tie game!") unless determine_winner
    winner, loser = determine_winner
    puts "#{winner.name} chose #{winner.hand}"
    puts "#{loser.name} chose #{loser.hand}"
    sleep(0.5)
    puts "#{winner.name} wins!"
    record_score
  end

  def standings
    puts "Current standings: "
    puts "#{computer.name}: #{computer.score}"
    puts "\tMoves: #{computer.hand_record.join(', ')}"
    puts "#{human.name}: #{human.score}"
    puts "\tMoves: #{human.hand_record.join(', ')}"
  end

  def check_standings?
    loop do
      puts "Want to see the standings? 'y' or 'n'"
      response = gets.chomp.downcase
      return true if response == 'y'
      return false if response == 'n'
      puts "Sorry, please only type 'y' or 'n' to choose"
    end
  end
end

class Move
  include Comparable

  VALUES = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'spock' => ['scissors', 'rock'],
    'lizard' => ['spock', 'paper']
  }

  def initialize
    @hand = self.class.to_s.downcase
  end

  def <=>(other)
    if VALUES[hand.to_s].include?(other.hand.to_s)
      1
    elsif VALUES[other.hand.to_s].include?(hand.to_s)
      -1
    else
      0
    end
  end

  def to_s
    hand
  end

  protected

  attr_accessor :hand
end

class Rock < Move
end

class Paper < Move
end

class Scissors < Move
end

class Lizard < Move
end

class Spock < Move
end

class Player
  # attr_reader :hand
  attr_accessor :name, :score, :hand_record, :hand

  def initialize
    @score = 0
    @hand = nil
    @hand_record = []
  end

  def record_hand
    hand_record.unshift(hand.to_s)
  end

  # private

  # attr_writer :hand
end

class Human < Player
  def initialize
    super
    set_name
  end

  def set_name
    puts "Please share your name"
    self.name = gets.chomp.capitalize
  end

  def decide_tournament
    loop do
      puts "Would you like to play a tournament?"
      puts "Best of 10 wins the grand prize. 'y' or 'n' ?"
      response = gets.chomp.downcase
      return true if response == 'y'
      return false if response == 'n'
      puts "Sorry, please only type 'y' or 'n' to choose"
    end
  end

  def choose
    loop do
      puts 'Please select rock, paper, scissors, lizard, or spock: '
      choice = gets.chomp.downcase
      if Move::VALUES.keys.include?(choice)
        # self.hand = Move.new(choice)
        self.hand = (Kernel.const_get(choice.capitalize)).new
        record_hand
        break
      end
      puts 'Sorry, that is not a valid choice.'
    end
  end
end

class Computer < Player
  attr_accessor :name, :score, :hand_record

  ROBOTS = ['Siri', 'BicentennialMan', "Eva", "Ava", 'Sonny', 'Alexa']

  def initialize
    super()
    @name = self.class.to_s
  end

  def choose
    # self.hand = Move.new(Move::VALUES.keys.sample)
    self.hand = (Kernel.const_get(Move::VALUES.keys.sample.capitalize)).new
    record_hand
  end
end

class Siri < Computer
  def choose
    self.hand = []
  end
end

class BicentennialMan < Computer
  def choose; end
end

class Eva < Computer
  def choose; end
end

class Sonny < Computer
  def choose; end
end

class Alexa < Computer
  def choose; end
end

class Ava < Computer
  def choose; end
end

class RPSGame
  include Displayable
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Kernel.const_get(Computer::ROBOTS.sample).new
  end

  def determine_winner
    return false if human.hand == computer.hand
    human.hand > computer.hand ? [human, computer] : [computer, human]
  end

  def record_score
    determine_winner.first.score += 1
  end

  def win?
    human.score >= 5 || computer.score >= 5
  end

  def play_again?
    sleep(0.5)
    loop do
      puts "Want to play again? Please enter 'y' or 'n'"
      repeat = gets.chomp.downcase
      return true if repeat == 'y'
      return false if repeat == 'n'
      puts "Sorry, please re-enter 'y' or 'n'"
    end
  end

  def play
    welcome
    human.decide_tournament
    loop do
      human.choose
      computer.choose
      round_outcome
      standings if check_standings?
      break if win?
      # break unless play_again?
    end

    goodbye
  end
end

RPSGame.new.play
