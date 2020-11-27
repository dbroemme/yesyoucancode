require_relative 'helpers'  # DO NOT REMOVE THIS LINE
#####################################################
#      Challenge #1: Get the price of Bitcoin       #
#####################################################

# We need to provide instructions to our friend to get
# the current price of Bitcoin. However, our friend
# doesn't know how to do that, so we need to tell
# them explicitly. We know that there is a website
# that has the data.

# Our instructions are as follows:
#
#   1. Get the current data from the website
#   2. From the data, get the 15 min price in U.S. Dollars
#   3. Tell me what the price is

# The website defined below has pricing data on Bitcoin
# You can use the name BLOCKCHAIN_WEBSITE as a parameter
# for the get_data_from_website() function
BLOCKCHAIN_WEBSITE = "https://blockchain.info/ticker"

# Step 1. Get the current data from the website
data = get_data_from_website(BLOCKCHAIN_WEBSITE)

# The data that comes back is in this format
# {
#  "USD" : {"15m" : 16766.22, "last" : 16766.22, "buy" : 16766.22, "sell" : 16766.22, "symbol" : "$"},
#  "AUD" : {"15m" : 22701.83, "last" : 22701.83, "buy" : 22701.83, "sell" : 22701.83, "symbol" : "$"},
#  ...
# }
# We have a helper function that will get the U.S. Dollar 15 min price
# This function is called get_price_in_usd(data)
# Step 2. From the data, get the 15 min price in U.S. Dollars
price = get_price_in_usd(data)

# Finally, we want to know the price so display it on the screen
# Use the helper function tell_me_the_price(price)
# Step 3. Tell me what the price is
tell_me_the_price(price)