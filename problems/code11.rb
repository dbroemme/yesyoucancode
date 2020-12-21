require_relative 'helpers'  # DO NOT REMOVE THIS LINE
#####################################################
#   Challenge 11: Lottery Analysis
#####################################################

# Helper function for displaying columns of text
def pad(str, size, left_align = false)
    str = str.to_s
    if left_align
        str[0, size].ljust(size, ' ')
    else
        str[0, size].rjust(size, ' ')
    end
end

# Step 1: Read the data file
# The data file comes from
# https://www.valottery.com/data/draw-games/pick4
# The format of this file is as follows:
#
# Results for Pick 4
# 12/20/2020; Day: 7,1,5,9; Night: 3,5,9,2
# 12/19/2020; Day: 7,7,9,8; Night: 2,9,4,1
# 12/18/2020; Day: 8,6,9,7; Night: 9,1,2,6
# ...
# 10/1/1991; Night: 5,1,5,3
# 9/30/1991; Night: 3,3,4,5
#
# All information is entered manually, and is subject to human error.
# Therefore, we can not guarantee the accuracy of this information.

# Step 2: For each line, split up the data into its parts
# Step 3: Keep track of the number of occurrences for each number
# Step 4: Display a list of the results

DATA_FILE = "./problems/Pick4_12_21_2020.txt"
total_drawings = 0
counts = []
(0..9).each do |i|
    counts[i] = 0
end

tell_me "Read the data file #{DATA_FILE}"
