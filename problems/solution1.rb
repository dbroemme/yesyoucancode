require_relative 'helpers'  # DO NOT REMOVE THIS LINE

BLOCKCHAIN_WEBSITE = "https://blockchain.info/ticker"
data = get_data_from_website(BLOCKCHAIN_WEBSITE)
price = get_price_in_usd(data)
tell_me_the_price(price)
