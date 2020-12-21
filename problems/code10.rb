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

# Copy your code from challenge 9 here
# Step 1: Loop through and prompt the user if they
#         want to hit or stay
# Step 2: Display their hand each time
# Step 3: Deal cards for the dealer until they reach
#         17 or higher         
# Step 4: Determine and display who won
#         The solution will just look for the word 'won'
#         in the output, so indicate who won.


