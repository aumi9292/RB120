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

class Card
  ACE_LOW = 1
  ACE_HIGH = 11

  attr_reader :value, :points

  def initialize(value, suit)
    @value = value
    @suit = suit
    @points = determine_points
  end

  def to_s
    "#{correct_article} #{value} of #{suit}"
  end

  def high
    ACE_HIGH
  end

  def low
    ACE_LOW
  end

  private

  attr_reader :suit

  def determine_points
    value.is_a?(Integer) ? value : ace_and_face_values
  end

  def ace_and_face_values
    value.match('Ace') ? [ACE_LOW, ACE_HIGH] : 10
  end

  def correct_article
    [8, 'Ace'].include?(value) ? 'An' : 'A'
  end
end

class Deck
  SUITS = ['Diamonds', 'Clubs', 'Hearts', 'Spades']
  VAL = (2..10).to_a + %w(Jack Queen King Ace)

  def draw
    cards.pop
  end

  def reset
    Deck.new
  end

  private

  attr_accessor :cards

  def initialize
    @cards = VAL.product(SUITS).map { |s, v| Card.new(s, v) }.shuffle!
  end
end

class Party
  attr_accessor :hand, :total
  attr_reader :name

  def initialize(name)
    @name = name
    @hand = []
    @total = 0
  end

  def display_bust
    puts "#{name} busts!" if bust?
  end

  def not_won_or_busted?
    !(win? || bust?)
  end

  def caluclate_total
    self.total = if aces.empty?
                   aceless_total
                 else
                   aces.reduce(aceless_total) do |pts, ace|
                     pts + ace.high <= 21 ? pts + ace.high : pts + ace.low
                   end
                 end
  end

  def bust?
    total > 21
  end

  def to_s
    name
  end

  def closing_statement
    puts "#{name} ends with #{total} points"
  end

  private

  def hit(deck)
    hand << deck.draw
    caluclate_total
  end

  def win?
    total == 21
  end

  def aceless_total
    hand.map(&:points).reject { |pts| pts.is_a?(Array) }.sum
  end

  def aces
    hand.select { |card| card.value == 'Ace' }
  end
end

class Player < Party
  def display_hand
    puts "#{name} has #{hand.length} cards worth #{total} points: "
    puts hand
  end

  def round(deck)
    hit(deck)
    display_hand
  end

  def can_continue?
    not_won_or_busted? && hit?
  end

  private

  def initialize
    super(choose_name)
  end

  def hit?
    Decision.new('Would you like to hit? (Y or N)').validated
  end

  def choose_name
    Decision.new('Please enter your name', ('a'..'z')).validated
  end
end

class Dealer < Party
  def hit(deck)
    hand << deck.draw
    caluclate_total
    display_hit
  end

  def round(deck)
    hit(deck) while not_won_or_busted? && less_than_dealer_minimum
    reveal
  end

  def display_first_card
    puts "The dealer has #{hand.length} cards. Her first card is: "
    puts hand.first
  end

  private

  def reveal
    puts "Dealer hand: "
    puts hand
  end

  def less_than_dealer_minimum
    total < 17
  end

  def display_hit
    puts "Dealer hits..."
  end
end

class TwentyOneGame
  WELCOME = "Welcome to 21! It's you versus the dealer.\n" \
  "\tThe goal of the game is to get as closer to 21 than the dealer.\n" \
  "\tCards 2 - King are worth 10, and Aces are worth 11 or 1."

  def initialize
    puts WELCOME
    @player = Player.new
    @dealer = Dealer.new('Dealer')
    @deck = Deck.new
    @parties = [player, dealer]
  end

  def gameplay
    loop do
      play
      play_again? ? clear_hands_and_reset_deck : break
    end
  end

  private

  attr_accessor :deck, :player, :dealer, :parties

  def initial_deal_and_reveal
    initial_deal
    reveal_hands
  end

  def initial_deal
    parties.each { |party| party.hand << deck.draw << deck.draw }
    parties.each(&:caluclate_total)
  end

  def reveal_hands
    player.display_hand
    dealer.display_first_card
  end

  def display_hand_comparison
    parties.each(&:closing_statement)
    display_winner
  end

  def display_winner
    puts dealer.total == player.total ? ("Tie game!") : ("#{winner} wins!")
  end

  def winner
    return player if dealer.bust?
    return dealer if player.bust?
    parties.max_by(&:total)
  end

  def clear_hands_and_reset_deck
    clear_hands
    self.deck = deck.reset
  end

  def clear_hands
    parties.each { |party| party.hand.clear }
  end

  def play
    initial_deal_and_reveal
    rounds if parties.all?(&:not_won_or_busted?)
  end

  def play_again?
    Decision.new("Would you like to play again? (Y or N)").validated
  end

  def rounds
    player.round(deck) while player.can_continue?
    dealer.round(deck) if player.not_won_or_busted?
    parties.each(&:display_bust)
    display_hand_comparison
  end
end

TwentyOneGame.new.gameplay
