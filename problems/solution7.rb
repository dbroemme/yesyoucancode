require_relative 'helpers'  # DO NOT REMOVE THIS LINE

class Calculator
    attr_accessor :total

    def initialize
        @total = 0
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

calc = Calculator.new
calc.add(5)
calc.multiply(78)
calc.divide(3)
calc.display
