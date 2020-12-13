require_relative 'helpers'  # DO NOT REMOVE THIS LINE

BLOCKCHAIN_WEBSITE = "https://blockchain.info/ticker"

# This helper instruction consolidates our earlier instructions
# so it is easier to reuse.
# Note that there are no parameters to this instruction
# so we can omit the parenthesis after the instruction name
def get_price_of_bitcoin
    data = get_data_from_website(BLOCKCHAIN_WEBSITE)
    price = get_price_in_usd(data)
    # This converts the string to a floating point number
    # Another conversion instruction is to_i (integer)
    price.to_f
end

def decide_to_buy(threshold_price, current_price)
    current_price < threshold_price
end

price = get_price_of_bitcoin
tell_me("The price is $#{price}")

decision = decide_to_buy(18000, price)
if decision
    tell_me("The decision is to buy.")
else
    tell_me("The decision is to wait.")
end
