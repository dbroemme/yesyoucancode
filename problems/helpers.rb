require_relative "./filequeue"
require 'net/http'
require 'json'
require 'date'

#$stdout.reopen(__dir__ + "/out.txt", "w")
@write_fq = FileQueue.new("r")
@read_fq = FileQueue.new("j")

def get_data_from_website(url)
    Net::HTTP.get(URI(url))
end

def get_price_in_usd(data)
    parsed_data = JSON.parse(data)
    price_in_usd = parsed_data["USD"]["15m"]
    return price_in_usd
end

def round(number_as_string)
    number_as_strint.to_f.round
end
####################
def open_the_calendar(year, month, day)
    Date.new(year, month, day)
end

def days_from_now(date)
    now = Date.today
    date.yday - now.yday
end
####################
def tell_me_the_price(text)
    puts "The price of Bitcoin is $#{text}"
end

def tell_me(text)
    puts text
end
####################
def yycc_puts(s)
    f = File.open(__dir__ + "/out.txt",'a')
    f.puts s
    f.close
end

def yycc_gets
    done = false
    count = 1
    value = nil
    @write_fq.push("gets")
    while not done
      puts "Checking #{count}"
      value = @read_fq.pop
      if value.nil?
        puts "did not get anything yet"
        sleep 2
      else
        puts "Got #{value}."
        done = true
      end
      count = count + 1
    end
    value
end
####################

#require_relative 'helpers'
#BLOCKCHAIN_WEBSITE = "https://blockchain.info/ticker"
#data = get_data_from_website(BLOCKCHAIN_WEBSITE)
#price = get_price_in_usd(data)
#tell_me_the_price(price)

