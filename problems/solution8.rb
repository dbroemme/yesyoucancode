require_relative 'helpers'  # DO NOT REMOVE THIS LINE

class Calculator
    attr_accessor :total

    def initialize(initial_value = 0)
        @total = initial_value
    end

    def add(value)
        @total = @total + value 
    end

    def subtract(value)
        @total = @total - value 
    end

    def multiply(value)
        @total = @total * value 
    end

    def divide(value)
        @total = @total / value 
    end
    
    def display
        tell_me @total
    end

end

STARTING_SALARY = 52000

calc = Calculator.new(STARTING_SALARY)
calc.multiply(0.03)
tell_me "The raise is #{calc.total}"

calc.add(STARTING_SALARY)
tell_me "The new salary is #{calc.total}"
