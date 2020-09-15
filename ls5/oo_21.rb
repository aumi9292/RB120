# description
# 21 is a game with two parties--the player and the dealer. The dealer shuffles a deck of cards and deals two cards to the player and to themselves. The player can see one of the dealer's cards and both of their own. The player can then choose to hit (draw another card) or stay. If the player chooses to stay, the player's turn is over and the dealer hits until they reach at least 17. However, if they choose to hit, they can continue hitting until they stay, bust (go over 21) or win exactly (get 21). If the player gets 21 or busts, the game is over and the computer never moves and still wins. If the player gets less than 21 and stays, the dealer then hits until they reach at least 17. If the dealer goes over, they bust. If they get 21 exactly, they win. If no one get 21 or bust, both parties' cards are compared and if the dealer gets closer to 21 than the player, they win.

# parties
# player
# dealer

# hand
# cards

# hit
# stay
# see
# compare

# busted
# 21 exactly

# game
# turn

# deck
# shuffle
# deal
# cards
# suit
# value

class Party
  def initialize
    @hand = Hand.new
    @bust_status = false
    @win_status = false
  end

  def hit; end

  def stay; end
end

class Hand
  def initialize
    @hand = []
    2.times { deck.draw }
  end

  def total; end
end

class Dealer < Player
  def reveal_one_card; end
end

class Deck
  SUITS = ['Diamonds', 'Clubs', 'Hearts', 'Spades']
  VAL = (2..10).to_a + %w(Jack Queen King Ace)

  attr_accessor :cards

  def initialize
    @cards = VAL.product(SUITS).map { |suit, value| Card.new(suit, value) }
  end

  def reset
    Deck.new
  end

  def draw
    cards.pop
  end
end


class Card
  include Comparable

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "a #{value} of #{suit}"
  end

  private

  attr_accessor :value, :suit
end

class TwentyOneGame
  def initialize(_name = 'Dealer')
    @player = Party.new('player')
    @dealer = Party.new
  end

  def play
    initial_deal 
    [player, dealer].each(&:round)
  end

  def initial_deal 
    deck.deal
    examine_hand
  end 

  def round
    hit? ? hit : stay
    lose if busted?
    win if exactly_21?
  end
end

TwentyOneGame.new.play
