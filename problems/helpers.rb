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
