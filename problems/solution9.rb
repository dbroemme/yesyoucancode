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
