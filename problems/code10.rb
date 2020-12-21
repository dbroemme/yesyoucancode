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

# Copy your code from challenge 9 here
# Step 1: Loop through and prompt the user if they
#         want to hit or stay
# Step 2: Display their hand each time
# Step 3: Deal cards for the dealer until they reach
#         17 or higher         
# Step 4: Determine and display who won
#         The solution will just look for the word 'won'
#         in the output, so indicate who won.
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
        @cards.each do |card|
            if total > 21
                if card.is_ace
                    total = total - 10
                end
            end
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

dealer_hand = Hand.new("Dealer")
my_hand = Hand.new("Darren")

dealer_hand.add_card(deck.deal)
my_hand.add_card(deck.deal)

dealer_hand.add_card(deck.deal)
my_hand.add_card(deck.deal)

newline
dealer_hand.display
newline
my_hand.display

done = false
while not done
    newline
    action = ask_me("(H)it or (S)tay?")
    if action == "H"
        my_hand.add_card(deck.deal)
        newline
        my_hand.display
        if my_hand.value > 21
            tell_me "Sorry, you busted with #{my_hand.value}. You went over 21."
            done = true
        elsif my_hand.value == 21
            tell_me "Congrats, you got 21!"
            done = true
        else
            # The player is under 21, so they still have
            # the option to hit again if they want.
        end
            
    elsif action == "S"
        tell_me("Great, you will stay at #{my_hand.value}")
        done = true
    else
        tell_me("Sorry, #{action} is not a valid choice.")
    end
end

# TODO handle the case of over 21 with an Ace

# Now for the dealer
# The dealer stays on anything 17 or above
newline
while dealer_hand.value < 17
    dealer_hand.add_card(deck.deal)
    newline
    dealer_hand.display
    sleep 2
end
newline

# Figure out who won and display the result
if dealer_hand.value > 21 and my_hand.value > 21
    tell_me "You both busted, nobody won."
elsif dealer_hand.value > 21
    tell_me "You won, the dealer busted."
elsif my_hand.value > 21
    tell_me "The dealer won, you busted."
elsif dealer_hand.value == my_hand.value
    tell_me "It was a push, nobody won. You and the dealer both had #{dealer_hand.value}."
elsif dealer_hand.value > my_hand.value
    tell_me "The dealer won. #{dealer_hand.value} beats your #{my_hand.value}"
else
    tell_me "You won! Your #{my_hand.value} beats the dealer's #{dealer_hand.value}"
end



