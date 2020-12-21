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
File.readlines(DATA_FILE).each do |line|
    line = line.chomp  # remove the carriage return

    if line.length > 0 and line[0].match(/[0-9]/)
        sections = line.split(";")
        str_date = sections[0]
        date = Date.strptime(str_date, "%m/%d/%Y")
        
        # There could be either one or two drawings
        # Older drawings only occurred at night
        (1..sections.size-1).each do |section_index|
            total_drawings = total_drawings + 1
            section = sections[section_index]
            str_numbers = section.partition(":")[2].strip
            numbers = str_numbers.split(",")
            numbers.each do |str_number|
                number = str_number.to_i
                counts[number] = counts[number] + 1
            end
        end
    end
end

newline
tell_me "Number of Pick4 drawings analyzed: #{total_drawings}"
newline
tell_me "#{pad('Number', 10)}  #{pad('Count', 10)}  #{pad('Percent', 10)}"
tell_me "#{'-' * 10}  #{'-' * 10}  #{'-' * 10}"
(0..9).each do |i|
    occurrences = counts[i]
    percent = (occurrences.to_f / total_drawings.to_f).round(5)
    tell_me "#{pad(i,10)}  #{pad(occurrences,10)}  #{pad(percent,10)}"
end
newline

# Create a hash so we can easily sort
hash = {}
(0..9).each do |i|
    hash[i] = counts[i]
end

# This gives us a nested set of arrays, in sorted order
# [ [number, count], [number, count], ...]
sorted_array = hash.sort_by { |number, count| count }
tell_me "#{pad('Number', 10)}  #{pad('Count', 10)}  #{pad('Percent', 10)}"
tell_me "#{'-' * 10}  #{'-' * 10}  #{'-' * 10}"
sorted_array.each do |number_and_count_array|
    number = number_and_count_array[0]
    occurrences = number_and_count_array[1]
    percent = (occurrences.to_f / total_drawings.to_f).round(5)
    tell_me "#{pad(number,10)}  #{pad(occurrences,10)}  #{pad(percent,10)}"
end
newline

