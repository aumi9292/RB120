require 'pry'
class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def check_switch
    switch
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

p m = Machine.new
p m.start
p m.check_switch
# p Machine.new.check_switch

# fixed arrays
# class FixedArray
#   def initialize(length, default = nil)
#     @length = length
#     @default_value = default
#     @object = [default] * length
#   end

#   def [](index)
#     object.fetch(index)
#   end

#   def []=(index, value)
#     object[index] = value if validate_index(index)
#   end

#   def validate_index(index)
#     index.between?(-length, length - 1)
#   end

#   def to_a
#     object
#   end

#   def to_s
#     (object).to_s
#   end

#   private

#   attr_accessor :length, :default_value, :object
# end

# fixed_array = FixedArray.new(5)
# puts fixed_array[3].nil?
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts fixed_array[1] == 'b'
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts fixed_array[1] == 'c'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts fixed_array[4] == 'd'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts fixed_array[-1] == 'd'
# puts fixed_array[-4] == 'c'

# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end
# puts fixed_array[6]
# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# puts fixed_array[7] = 3

# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# students
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, _parking)
    @parking = true
    super(name, year)
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end

# circular queue
class CircularQueue
  attr_accessor :buffer

  def initialize(buffer_size)
    @buffer = Array.new
    @max_size = buffer_size
  end

  def enqueue(new_item)
    buffer.size == max_size ? replace_rotate(new_item) : buffer.push(new_item)
  end

  def dequeue
    buffer.shift
  end

  private

  attr_reader :max_size

  def replace_rotate(new_item)
    buffer[0] = new_item
    buffer.rotate!
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue.nil?

queue.enqueue(1)
queue.enqueue(2)
p queue.buffer
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2
p queue.buffer
queue.enqueue(5)
queue.enqueue(6)
p queue.buffer

queue.enqueue(7)
p queue.buffer
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue.nil?

queue = CircularQueue.new(4)
puts queue.dequeue.nil?

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue.nil?

# minilang
# given a string of commands and integers, implement a class that has a 'register', a current value that is an integer, and a stack, which is a list of values. Commands are integer operations and PUSH, which moves the register value to the stack (while leaving the value in the register). All integer operations are performed bw the final value in the stack, and the register.

# input is given in the form of a string of commands and integers
# string must be parsed: split by spaces,
# '5 PUSH 3 MULT PRINT' --> ['5', 'PUSH', 'MULT', 'PRINT']

class Minilang
  attr_accessor :register, :stack, :arg_array

  ERROR_MESSAGE = "Invalid Token: "

  def initialize(arg_string)
    @register = 0
    @stack = []
    @arg_array = validated(parse(arg_string))
  end

  def parse(arg_string)
    arg_string.downcase.split(' ').map { |w| w.to_i.to_s == w ? w.to_i : w }
  end

  def valid_condtions(w)
    w.is_a?(Integer) || methods.include?(w.to_sym)
  end

  def error(specifics)
    ERROR_MESSAGE + (specifics.upcase)
  end

  def validated(arg_array)
    arg_array.each { |w| return error(w) unless valid_condtions(w) }
  end

  def eval
    return arg_array if arg_array.is_a?(String)
    arg_array.each { |w| w.is_a?(Integer) ? self.register = w : send(w.to_sym) }
  end

  def push
    stack << register
  end

  def pop
    if stack.empty?
      puts "Empty Stack!"
    else
      self.register = stack.pop
    end
  end

  def print
    puts register
  end

  def add
    self.register += pop
  end

  def sub
    self.register -= pop
  end

  def mult
    self.register *= pop
  end

  def div
    self.register /= pop
  end

  def mod
    self.register %= pop
  end
end

p Minilang.methods
p Minilang.new('PRINT').eval
puts
p Minilang.new('5 PUSH 3 MULT PRINT').eval
Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

p Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

p Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval

# number guessing game
# class GuessingGame
#   attr_accessor :secret_num, :player_guesses, :guess

#   TRIES = 7
#   MSG = { high: "Your guess is too high",
#           exact: "That's the number!",
#           low: "Your guess is too low",
#           lose: "You have no more guesses. You lose!" }

#   def initialize
#     @secret_num = rand(1..100)
#     @guess = nil
#     @player_guesses = []
#   end

#   def play
#     guess_and_tell until ending_contitions
#   end

#   def guess_and_tell
#     acquire_guess
#     record_guess
#     describe
#   end

#   def ending_contitions
#     player_guesses.length == TRIES || secret_num == player_guesses.last
#   end

#   def guess_message
#     "You have #{TRIES - player_guesses.length} guesses remaining." \
#     "Enter a number between 1 and 100: "
#   end

#   def acquire_guess
#     loop do
#       puts guess_message
#       to_check = gets.chomp.to_i
#       if to_check.between?(1, 100)
#         self.guess = to_check
#         break
#       end
#       puts "Invalid guess"
#     end
#     record_guess
#   end

#   def record_guess
#     player_guesses << guess
#   end

#   def describe
#     puts guess == secret_num ? (MSG[:exact]) : high_or_low
#     inform_end
#   end

#   def high_or_low
#     guess < secret_num ? (MSG[:low]) : (MSG[:high])
#   end

#   def inform_end
#     puts MSG[:lose] if lose
#   end

#   def lose
#     player_guesses.length == TRIES
#   end
# end

# GuessingGame.new.play

# guessing game pt 2

class GuessingGame
  attr_accessor :secret_num, :player_guesses, :guess, :tries, :low, :high

  MSG = { high: "Your guess is too high",
          exact: "That's the number!",
          low: "Your guess is too low",
          lose: "You have no more guesses. You lose!" }

  def initialize(low = 501, high = 1500)
    @low = low
    @high = high
    @secret_num = rand(low..high)
    @guess = nil
    @player_guesses = []
    @tries = Math.log2(high - low).to_i + 1
  end

  def play
    guess_and_tell until ending_contitions
  end

  def guess_and_tell
    acquire_guess
    record_guess
    describe
  end

  def ending_contitions
    player_guesses.length == tries || secret_num == player_guesses.last
  end

  def guess_message
    "You have #{tries - player_guesses.length} guesses remaining." \
    "Enter a number between #{low} and #{high}: "
  end

  def acquire_guess
    loop do
      puts guess_message
      to_check = gets.chomp.to_i
      if to_check.between?(low, high)
        self.guess = to_check
        break
      end
      puts "Invalid guess"
    end
  end

  def record_guess
    player_guesses << guess
  end

  def describe
    puts guess == secret_num ? (MSG[:exact]) : high_or_low
    inform_end
  end

  def high_or_low
    guess < secret_num ? (MSG[:low]) : (MSG[:high])
  end

  def inform_end
    puts MSG[:lose] if lose
  end

  def lose
    player_guesses.length == tries
  end
end

# GuessingGame.new.play

# highest and lowest cards
# class Card
#   include Comparable
#   attr_reader :suit, :rank

#   FACES = {
#     'Jack' => 11,
#     'Queen' => 12,
#     'King' => 13,
#     'Ace' => 14
#   }

#   VAL = { 'Diamonds' => 1,
#           'Clubs' => 2,
#           'Hearts' => 3,
#           'Spades' => 4 }

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def rank_to_compare
#     rank.is_a?(Integer) ? rank : FACES[rank]
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   def <=>(other)
#     [rank_to_compare, VAL[suit]] <=> [other.rank_to_compare, VAL[suit]]
#   end
# end

# cards = [Card.new(2, 'Hearts'), Card.new(2, 'Diamonds'), Card.new(10, 'Diamonds'), Card.new(2, 'Clubs'), Card.new(10, 'Clubs')]

# p cards.sort

# cards = [Card.new(2, 'Hearts'),
#          Card.new(10, 'Diamonds'),
#          Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')
# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#          Card.new(4, 'Diamonds'),
#          Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#          Card.new('Jack', 'Diamonds'),
#          Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#          Card.new(8, 'Clubs'),
#          Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8

# try 2
# class Card
#   include Comparable
#   attr_reader :suit, :rank

#   FACES = {
#     'Jack' => 11,
#     'Queen' => 12,
#     'King' => 13,
#     'Ace' => 14
#   }

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def rank_to_compare
#     rank.is_a?(Integer) ? rank : FACES[rank]
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   def <=>(other)
#     [rank_to_compare, suit] <=> [other.rank_to_compare, suit]
#   end
# end

# cards = [Card.new(2, 'Hearts'),
#          Card.new(10, 'Diamonds'),
#          Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')
# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#          Card.new(4, 'Diamonds'),
#          Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#          Card.new('Jack', 'Diamonds'),
#          Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#          Card.new(8, 'Clubs'),
#          Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8

class Card
  include Comparable
  attr_reader :suit, :rank

  FACES = {
    'Jack' => 11,
    'Queen' => 12,
    'King' => 13,
    'Ace' => 14
  }

  VAL = { 'Diamonds' => 1,
          'Clubs' => 2,
          'Hearts' => 3,
          'Spades' => 4 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def rank_to_compare
    rank.is_a?(Integer) ? rank : FACES[rank]
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other)
    [rank_to_compare, VAL[suit]] <=> [other.rank_to_compare, VAL[suit]]
  end
end

class Deck
  attr_accessor :deck

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = []
    create_cards
  end

  def draw
    create_cards if deck.empty?
    deck.pop
  end

  private

  def create_cards
    RANKS.product(SUITS).each { |rank, suit| deck << Card.new(rank, suit) }
    deck.shuffle!
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2

class PokerHand
  attr_reader :hand

  def initialize(deck)
    @hand = []
    5.times { @hand << deck.draw }
  end

  def print
    puts hand
  end

  def evaluate
    if royal_flush? then 'Royal flush'
    elsif straight_flush?  then 'Straight flush'
    elsif four_of_a_kind?  then 'Four of a kind'
    elsif full_house?      then 'Full house'
    elsif flush?           then 'Flush'
    elsif straight?        then 'Straight'
    elsif three_of_a_kind? then 'Three of a kind'
    elsif two_pair?        then 'Two pair'
    elsif pair?            then 'Pair'
    else 'High card'
    end
  end

  private

  def royal_flush?
    (values.sort == (10..14).to_a) && flush?
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    values.any? { |val| values.count(val) == 4 }
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    suits.uniq.one?
  end

  def straight?
    values.sort == (values.min..values.max).to_a
  end

  def three_of_a_kind?
    values.any? { |val| values.count(val) == 3 }
  end

  def two_pair?
    values.count { |val| values.count(val) == 2 } > 2
  end

  def pair?
    values.any? { |val| values.count(val) == 2 }
  end

  def suits
    hand.map(&:suit)
  end

  def values
    hand.map(&:rank_to_compare)
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias draw pop
end

puts
# Test that we can identify each PokerHand type.
hand = PokerHand.new([
                       Card.new(10,      'Hearts'),
                       Card.new('Ace',   'Hearts'),
                       Card.new('Queen', 'Hearts'),
                       Card.new('King',  'Hearts'),
                       Card.new('Jack',  'Hearts')
                     ])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
                       Card.new(8,       'Clubs'),
                       Card.new(9,       'Clubs'),
                       Card.new('Queen', 'Clubs'),
                       Card.new(10,      'Clubs'),
                       Card.new('Jack',  'Clubs')
                     ])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
                       Card.new(3, 'Hearts'),
                       Card.new(3, 'Clubs'),
                       Card.new(5, 'Diamonds'),
                       Card.new(3, 'Spades'),
                       Card.new(3, 'Diamonds')
                     ])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
                       Card.new(3, 'Hearts'),
                       Card.new(3, 'Clubs'),
                       Card.new(5, 'Diamonds'),
                       Card.new(3, 'Spades'),
                       Card.new(5, 'Hearts')
                     ])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
                       Card.new(10, 'Hearts'),
                       Card.new('Ace', 'Hearts'),
                       Card.new(2, 'Hearts'),
                       Card.new('King', 'Hearts'),
                       Card.new(3, 'Hearts')
                     ])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
                       Card.new(8, 'Clubs'),
                       Card.new(9,      'Diamonds'),
                       Card.new(10,     'Clubs'),
                       Card.new(7,      'Hearts'),
                       Card.new('Jack', 'Clubs')
                     ])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
                       Card.new('Queen', 'Clubs'),
                       Card.new('King',  'Diamonds'),
                       Card.new(10,      'Clubs'),
                       Card.new('Ace',   'Hearts'),
                       Card.new('Jack',  'Clubs')
                     ])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
                       Card.new(3, 'Hearts'),
                       Card.new(3, 'Clubs'),
                       Card.new(5, 'Diamonds'),
                       Card.new(3, 'Spades'),
                       Card.new(6, 'Diamonds')
                     ])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
                       Card.new(9, 'Hearts'),
                       Card.new(9, 'Clubs'),
                       Card.new(5, 'Diamonds'),
                       Card.new(8, 'Spades'),
                       Card.new(5, 'Hearts')
                     ])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
                       Card.new(2, 'Hearts'),
                       Card.new(9, 'Clubs'),
                       Card.new(5, 'Diamonds'),
                       Card.new(9, 'Spades'),
                       Card.new(3, 'Diamonds')
                     ])
puts hand.evaluate #== 'Pair'

hand = PokerHand.new([
                       Card.new(2, 'Hearts'),
                       Card.new('King', 'Clubs'),
                       Card.new(5,      'Diamonds'),
                       Card.new(9,      'Spades'),
                       Card.new(3,      'Diamonds')
                     ])
puts hand.evaluate == 'High card'
