require_relative 'helpers'  # DO NOT REMOVE THIS LINE
#####################################################
#   Challenge 9: BlackJack: Deal a hand to two players
#####################################################

#############################################################
# Objects and constants used in Blackjack
#############################################################

# Array Index  0    1    2    3    4    5    6    7     8     9   10   11   12
CARD_RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
CARD_VALUE = [ 2,   3,   4,   5,   6,   7,   8,   9,   10,   10,  10,  10,  11]
CARD_SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
ACE_RANK = 12

class Card
    # The rank and suit are stored as integers that reference the constant
    # arrays above when they need to be displayed.
    attr_accessor :rank
    attr_accessor :suit

    def initialize(rank, suit)
        @rank = rank
        @suit = suit
    end

    def value
        CARD_VALUE[@rank]
    end

    def is_ace
        @rank == ACE_RANK
    end

    def display
        tell_me "#{CARD_RANKS[@rank]} #{CARD_SUITS[@suit]}"
    end
end

# Step 1: Create an instance of a Deck of cards

# Step 2: Shuffle the deck

# Step 3: Deal two cards to each player

# Step 4: Display the hands
class Deck
    attr_accessor :cards

    def initialize
        @cards = []
        (0..12).each do |current_rank|
            (0..3).each do |current_suit|
                @cards << Card.new(current_rank, current_suit)
            end
        end
    end

    def shuffle
        @cards.shuffle!
    end

    def deal
        @cards.pop
    end

    def display
        @cards.each do |card|
            card.display
        end
    end
end

class Hand
    attr_accessor :player
    attr_accessor :cards

    def initialize(player_name)
        @player = player_name
        @cards = []
    end

    def add_card(card)
        @cards << card 
    end

    def value
        total = 0
        @cards.each do |card|
            total = total + card.value
        end
        total
    end

    def display
        tell_me "Player: #{@player}   Value: #{value}"
        @cards.each do |card|
            card.display
        end
    end
end


deck = Deck.new
deck.shuffle

hand1 = Hand.new("Dealer")
hand2 = Hand.new("Darren")

hand1.add_card(deck.deal)
hand2.add_card(deck.deal)

hand1.add_card(deck.deal)
hand2.add_card(deck.deal)

newline
hand1.display
newline
hand2.display

