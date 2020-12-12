require_relative 'helpers'  # DO NOT REMOVE THIS LINE

birthday = ask_me("When is your birthday (MM/DD)?")
days_left = calculate_days_until(birthday)
tell_me("There are #{days_left} days left.")
