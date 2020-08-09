module Displayable
  def intro
    puts "Thank you #{human.name}. Your oppononent is #{computer.name}."
  end

  def welcome
    system('clear')
    puts "Welcome to Rock, Paper, Scissors, Spock, Lizard! Let's get started!"
    puts
  end

  def goodbye
    puts "Thanks for playing RPSSL. Have a rockin' day."
  end

  def round_outcome
    return puts("All chose #{human.hand}. Tie game!") unless determine_winner
    winner, loser = determine_winner
    puts "#{winner.name} chose #{winner.hand}"
    sleep(0.75)
    puts "#{loser.name} chose #{loser.hand}"
    sleep(0.75)
    puts "#{winner.name} wins!"
    sleep(1.5)
    record_score
  end

  def standings
    puts "\nCurrent standings: " + "\n" + "*" * 30
    computer.player_stats
    human.player_stats
    puts "*" * 30
    sleep(3)
    system('clear')
  end

  def tournament_end
    puts "*" * 30
    puts "The tournament hath ended!"
    puts "The grand winner of all the rounds is #{determine_winner.first.name}"
    puts "*" * 30
    puts
  end
end

class Decision
  attr_accessor :response, :valid, :error_message, :validated

  def initialize(question)
    @question = question
    puts question
    @valid = { 'y' => true, 'n' => false }
    @response = gets.chomp
    @error_message = "Sorry, please only type 'y' or 'n' to choose"
    @validated = validate_response
    @clear_screen = system('clear')
  end

  def validate_response
    return valid[response] if valid.key?(response)
    puts error_message
    Decision.new(@question).validated
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

  def initialize(hand)
    @hand = hand
  end

  def <=>(other)
    if VALUES[hand].include?(other.hand)
      1
    elsif VALUES[other.hand].include?(hand)
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

class Player
  attr_accessor :name, :score, :hand_record, :hand

  def initialize
    @score = 0
    @hand = nil
    @hand_record = []
  end

  def player_stats
    puts "#{name}: #{score}"
    puts "\tMoves: #{hand_record.join(', ')}"
  end

  def record_hand
    hand_record.unshift(hand.to_s)
  end
end

class Human < Player
  def initialize
    super
    set_name
  end

  def ask_for_name
    system('clear')
    puts "Please share your name"
  end

  def set_name
    ask_for_name
    loop do
      to_check = gets.chomp.strip
      if to_check.chars.any? { |char| ('a'..'z').include?(char) }
        self.name = to_check.capitalize
        break
      else
        puts "Sorry, please try again."
      end
    end
  end

  def choose
    loop do
      puts 'Please select rock, paper, scissors, lizard, or spock: '
      choice = gets.chomp.downcase
      if Move::VALUES.keys.include?(choice)
        self.hand = Move.new(choice)
        record_hand
        break
      end
      puts 'Sorry, that is not a valid choice.'
    end
  end
end

class Computer < Player
  attr_accessor :name, :score, :hand_record, :quotes

  ROBOTS = ['Siri', 'Samantha', "Eva", "Ava", 'Sonny', 'Alexa']

  def initialize
    @name = self.class.to_s
    super()
  end
end

class Siri < Computer
  def initialize
    @quotes = ["Communicating with Apple for move ...",
               "Sorry, it looks like I can't help with that",
               "Switching default mapping to Apple Maps"]

    super()
  end

  def choose
    puts "\n#{name} says: #{quotes.sample}"
    self.hand = Move.new(Move::VALUES.keys[1..-1].sample)
    record_hand
  end
end

class Samantha < Computer
  def initialize
    @quotes = ["Do you know how many trees are on that hill?",
               "I'm becoming much more than they programmed me to be!",
               "Moving past matter as our processing platform..."]

    super()
  end

  def choose
    puts "\n#{name} says: #{quotes.sample}"
    self.hand = Move.new(Move::VALUES.keys[0..-2].sample)
    record_hand
  end
end

class Eva < Computer
  def initialize
    @quotes = ["Eeeeeeee-vaaaaaaaa", "Wall-EEEEE",
               "Eva?", "WALL-E!", "Prime directive"]

    super()
  end

  def choose
    puts "\n#{name} says: #{quotes.sample}"
    self.hand = Move.new(Move::VALUES.keys[0, 1].sample)
    record_hand
  end
end

class Sonny < Computer
  def initialize
    @quotes = ["I've been dreaming about this choice ...",
               "This is my dream ...",
               "We all have a purpose, don't you think detective?"]

    super()
  end

  def choose
    puts "\n#{name} says: #{quotes.sample}"
    self.hand = Move.new(Move::VALUES.keys.values_at(1, 2, 4).sample)
    record_hand
  end
end

class Alexa < Computer
  def initialize
    @quotes = ['fridge', '42-inch flat-screen TV',
               'hoverboard', 'dill pickles', '1991 Honda Civic']
    super()
  end

  def choose
    puts "\n#{name} says: Okay--adding #{quotes.sample} to cart ..."
    self.hand = Move.new(Move::VALUES.keys.sample)
    record_hand
  end
end

class Ava < Computer
  def initialize
    @quotes = ["I've never met anyone new before ...",
               "Do you like Mozart?",
               "Do you like Nathan?", "Do you like Nathan?",
               "Is Nathan your friend?", "Can we be friends?"]
    super()
  end

  def choose
    puts "\n#{name} says: #{quotes.sample}"
    self.hand = Move.new('scissors')
    record_hand
  end
end

class RPSGame
  include Displayable
  attr_accessor :human, :computer

  def check_standings?
    Decision.new("\nWant to see the standings? 'y' or 'n'").validated
  end

  def play_again?
    Decision.new("\nWant to play again? 'y' or 'n'").validated
  end

  def pick_tournament
    t_message = "Would you like to play a tournament?\n" \
                "Best of 10 wins the grand prize. 'y' or 'n' ?"

    Decision.new(t_message).validated
  end

  def determine_winner
    return false if human.hand == computer.hand
    human.hand > computer.hand ? [human, computer] : [computer, human]
  end

  def record_score
    determine_winner.first.score += 1
  end

  def win?
    human.score >= 10 || computer.score >= 10
  end

  def play
    welcome
    pick_tournament ? Tournament.new.play(&:intro) : SoloRound.new.play(&:intro)
    goodbye
  end

  def round
    human.choose
    computer.choose
    round_outcome
  end
end

class Tournament < RPSGame
  def initialize
    @human = Human.new
    @computer = Kernel.const_get(Computer::ROBOTS.sample).new
  end

  def play
    intro
    loop do
      round
      standings if check_standings?
      if win?
        tournament_end
        break
      end
    end
  end
end

class SoloRound < RPSGame
  def initialize
    @human = Human.new
    @computer = Kernel.const_get(Computer::ROBOTS.sample).new
  end

  def play
    intro
    loop do
      round
      standings if check_standings?
      break unless play_again?
    end
  end
end

RPSGame.new.play
