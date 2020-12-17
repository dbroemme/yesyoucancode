require_relative "./filequeue"
require_relative "./yycc"
require 'net/http'
require 'json'
require 'date'

def get_data_from_website(url)
    Net::HTTP.get(URI(url))
end

def get_price_in_usd(data)
    parsed_data = JSON.parse(data)
    price_in_usd = parsed_data["USD"]["15m"]
    return price_in_usd
end

def create_personal_greeting(name)
    "Hello #{name}"
end

def calculate_days_until(birthday)
    # The birthday is a string with the format MM/DD
    month = birthday[0..1]
    day = birthday[3..4]
    now = Time.now
    bday = Time.new(now.year, month.to_i, day.to_i)
    if bday < now
        # We need to set the year to next year
        bday = Time.new(now.year + 1, month.to_i, day.to_i)
    end
    # Now get the difference in days between the two
    ((bday - now).to_i / (24 * 60 * 60)) + 1
end

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

    def to_display
        "#{CARD_RANKS[@rank]} #{CARD_SUITS[@suits]}"
    end

end

class Deck
    attr_accessor :cards

    def initialize
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
            tell_me(card.to_display)
        end
    end
end

class Hand
    attr_accessor :cards

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
        @cards.each do |card|
            tell_me(card.to_display)
        end
    end
end

#############################################################
# Below this point are functions used by the Yes You Can Code
# helper that deal with input and output, so the helper
# can show the output in the window and compare it to
# expected results. It also helps deal with collecting
# input from the user.
#############################################################

@write_fq = FileQueue.new("r")
@read_fq = FileQueue.new("j")

def tell_me(text)
    yycc_puts text
end

def ask_me(text)
    yycc_puts text
    yycc_gets.chomp
end

####################
def yycc_puts(s)
    if MANAGED_RUN_MODE
      f = File.open(__dir__ + "/../log/out.txt",'a')
      f.puts s
      f.close
    else
      puts s 
    end
end

def yycc_gets
    if MANAGED_RUN_MODE
        done = false
        count = 1
        value = nil
        @write_fq.push("gets")
        while not done
            #yycc_puts "Checking #{count}"
            value = @read_fq.pop
            if value.nil?
                #yycc_puts "did not get anything yet"
                sleep 0.5
            else
                #yycc_puts "Got #{value}."
                done = true
            end
            count = count + 1
            if count > 600
                done = true
                yycc_puts "Stopped waiting for input after 5 minutes."
                value = "no data entered"
            end
        end
        return value
    else
        return gets
    end
end
