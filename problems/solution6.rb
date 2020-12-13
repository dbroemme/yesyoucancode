require_relative 'helpers'  # DO NOT REMOVE THIS LINE

class Question
    attr_accessor :question
    attr_accessor :possible_answers
    attr_accessor :correct_answer
    
    def initialize(question)
        @question = question
        @possible_answers = []
    end
    
    def add_possible_answer(possible_answer)
        @possible_answers << possible_answer
    end
    
    def is_correct_answer(answer)
        answer == @correct_answer
    end
end

# Step 0: Create your own questions. Below is a sample
question1 = Question.new("What is the largest U.S. state by land area?")
question1.add_possible_answer("A. Alaska")
question1.add_possible_answer("B. California")
question1.add_possible_answer("C. Montana")
question1.add_possible_answer("D. Texas")
question1.correct_answer = "A"

# Step 1: Create an array of your Questions
question_array = [question1]
total_correct = 0

# Step 2: Loop through the array of Questions
#   Loop instruction 1): Ask the user the question
#   Loop instruction 2): Determine if the answer is correct
#   Loop instruction 3): Keep track of results
question_array.each do |question|
    tell_me(question.question)
    question.possible_answers.each do |possible_answer|
        tell_me(possible_answer)
    end
    tell_me(" ")
    answer = ask_me("What is your answer?")
    if question.is_correct_answer(answer)
        total_correct = total_correct + 1
    end
end

# Step 3: Display the final results as "Number correct: #{number}"
tell_me("Number correct: #{total_correct}")
