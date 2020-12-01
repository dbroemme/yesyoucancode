require_relative "./filequeue"
require_relative "./yycc"
require 'net/http'
require 'json'
require 'date'

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
    yycc_puts "The price of Bitcoin is $#{text}"
end

def tell_me(text)
    yycc_puts text
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
            yycc_puts "Checking #{count}"
            value = @read_fq.pop
            if value.nil?
                yycc_puts "did not get anything yet"
                sleep 2
            else
                yycc_puts "Got #{value}."
                done = true
            end
            count = count + 1
        end
        return value
    else
        return gets
    end
end
