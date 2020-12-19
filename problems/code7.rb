require_relative 'helpers'  # DO NOT REMOVE THIS LINE
#####################################################
#   Challenge 7: Calculator
#####################################################
 
# Step 1: Define a calculator class
#   Write a method for each arithmetic operation
#   Write a method to display the current total

# Step 2: Compute 5 multiplied by 78

# Step 3: Compute that result divided by 3

# Step 4: Display the result

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
#calc2.display
