require_relative 'helpers'  # DO NOT REMOVE THIS LINE
#####################################################
#   Challenge #1: Get the price of Bitcoin
#####################################################

# The website defined below has pricing data on Bitcoin
BLOCKCHAIN_WEBSITE = "https://blockchain.info/ticker"

# Step 1. Get the current data from the website
data = get_data_from_website(BLOCKCHAIN_WEBSITE)

# Step 2. From the data, get the 15 min price in U.S. Dollars
price = get_price_in_usd(data)

# Finally, display the price on the screen
tell_me("The price of Bitcoin is #{price}")