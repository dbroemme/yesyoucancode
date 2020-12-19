require_relative 'helpers'  # DO NOT REMOVE THIS LINE

class Calculator
    attr_accessor :total

    def initialize
        @total = 0.0
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
    
    def display(precision = 0)
        tell_me @total.round(precision)
    end
end

calc1 = Calculator.new
calc1.add(5)
calc1.multiply(78)
calc1.divide(3)
calc1.display

calc2 = Calculator.new
calc2.add(10)
calc2.divide(3)
calc2.display(2)
