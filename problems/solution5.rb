require_relative 'helpers'  # DO NOT REMOVE THIS LINE

seconds = 10
while seconds > 0
    tell_me("#{seconds} seconds left")
    seconds = seconds - 1
    sleep 1
end

tell_me("Done")
