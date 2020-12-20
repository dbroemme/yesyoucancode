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
        # TODO Deal with an Ace which could be 1 or 11
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

