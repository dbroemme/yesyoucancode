require_relative 'helpers'  # DO NOT REMOVE THIS LINE

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

hand1 = Hand.new("Darren")
hand2 = Hand.new("Alice")

hand1.add_card(deck.deal)
hand2.add_card(deck.deal)

hand1.add_card(deck.deal)
hand2.add_card(deck.deal)

newline
hand1.display
newline
hand2.display

done = false
while not done
    newline
    action = ask_me("(H)it or (S)tay?")
    if action == "H"
        hand2.add_card(deck.deal)
        newline
        hand2.display
        if hand2.value > 21
            tell_me "Sorry, you busted with #{hand1.value}. You went over 21."
            done = true
        elsif hand2.value == 21
            tell_me "Congrats, you got 21!"
            done = true
        else
            # The player is under 21, so they still have
            # the option to hit again if they want.
        end
            
    elsif action == "S"
        tell_me("Great, you will stay at #{hand1.value}")
        done = true
    else
        tell_me("Sorry, #{action} is not a valid choice.")
    end
end

# Now for the dealer
# The dealer stays on anything 17 or above
newline
while hand1.value < 17
    hand1.add_card(deck.deal)
    newline
    hand1.display
    sleep 3
end
newline

# Figure out who won and display the result
if hand1.value == hand2.value
    tell_me "It was a push, nobody won. You and the dealer both had #{hand1.value}."
elsif hand1.value > hand2.value
    tell_me "The dealer won. #{hand1.value} beats you #{hand2.value}"
else
    tell_me "You won! #{hand2.value} beats the dealer's #{hand1.value}"
end
