require_relative 'helpers'  # DO NOT REMOVE THIS LINE

name = ask_me("What is your name?")
greeting = create_personal_greeting(name)
tell_me(greeting)
