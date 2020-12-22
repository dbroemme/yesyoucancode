require_relative 'helpers'  # DO NOT REMOVE THIS LINE
require 'decisiontree'
#####################################################
#   Challenge 12: Predicting Populariyy of Articles
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

#
# Original data file is problems/OnlineNewsPopularity.csv
# The file problems/OnlineNewsPopularity.names has more information.
# The data set is from the following research.
#
#    K. Fernandes, P. Vinagre and P. Cortez. A Proactive Intelligent Decision
#    Support System for Predicting the Popularity of Online News. Proceedings
#    of the 17th EPIA 2015 - Portuguese Conference on Artificial Intelligence,
#    September, Coimbra, Portugal.
#
# The data was preprocessed and simplified a bit in our DATA_FILE.
# The format is as follows: 
#
# url,number_of_words,number_of_unique_tokens,number_of_links,
# number_of_images,number_of_videos,number_of_keywords,
# day_of_week,is_entertainment,is_business,is_socmed,is_tech,
# is_world,rate_positive_words,rate_negative_words,
# article_shares,shares_classification
DATA_FILE = "./problems/article_data.csv"
DEFAULT_CLASSIFICATION = "Low"
tell_me "Reading the data file #{DATA_FILE}"

all_data = []
weekday_data = []
weekday_keywords_data = []
category_data = []

File.readlines(DATA_FILE).each do |line|
    line = line.chomp  # remove the carriage return        
    tokens = line.split(",")
    
    # Example data row, first line from file
    # 0 http://mashable.com/.../car-of-the-future-infographic/  url
    # 1 97.0             number_of_words
    # 2 0.670103085875   number_of_unique_tokens
    # 3 2.0              number_of_links
    # 4 0.0              number_of_images
    # 5 0.0              number_of_videos
    # 6 7.0              number_of_keywords
    # 7 Monday           day_of_Week
    # 8 0                lifestyle
    # 9 0                entertainment
    #10 0                business
    #11 0                socmed
    #12 1                tech
    #13 1                world
    #14 0.6              rate_positive_words
    #15 0.4              rate_negative_words
    #16 3600             shares
    #17 Great            classification
    url = tokens[0]
    number_of_words = tokens[1].to_i
    number_of_unique_tokens = tokens[2].to_i
    number_of_links = tokens[3].to_i
    number_of_images = tokens[4].to_i
    number_of_videos = tokens[5].to_i
    number_of_keywords = tokens[6].to_i
    day_of_week = tokens[7]
    is_lifestyle = tokens[8].to_i
    is_entertainment = tokens[9].to_i
    is_business = tokens[10].to_i
    is_socmed = tokens[11].to_i
    is_tech = tokens[12].to_i
    is_world = tokens[13].to_i
    rate_positive_words = tokens[14].to_f
    rate_negative_words = tokens[15].to_f
    shares = tokens[16].to_i
    shares_classification = tokens[17]

    # We needed to bin the article based on the number of shares
    # so we can train the classifier using a string token, or classification.
    # The range of shares for our data set is as shown below.
    # p10   p50    p90    p99         average
    # 708   1400   6200   31656       3395          
    # 
    # The following bins were used for classification:
    #
    # 0    - 500     Low
    # 501  - 1000    Moderate
    # 1001 - 1400    Good    
    # 1401 - 2000    Very Good    
    # 2001 - 5000    Great    
    # 5001 +         Excellent    

    all_data << [number_of_words, number_of_unique_tokens, number_of_links,
                 number_of_images, number_of_videos, number_of_keywords, day_of_week,
                 is_lifestyle, is_entertainment, is_business, is_socmed,
                 is_tech, is_world, rate_positive_words, rate_negative_words, shares_classification]

    weekday_data << [day_of_week, shares_classification]
    weekday_keywords_data << [day_of_week, number_of_keywords, shares_classification]
    category = ""
    if is_lifestyle == 1
        category = "Lifestyle"
    elsif is_entertainment == 1
        category = "Entertainment"
    elsif is_business == 1
        category = "Business"
    elsif is_socmed == 1
        category = "SocMed"
    elsif is_tech == 1
        category = "Tech"
    elsif is_world == 1
        category = "World"
    end
    category_data << [category, day_of_week, number_of_keywords, shares_classification]
end

all_attributes = ["Words", "Unique Tokens", "Links", "Images",
                  "Videos", "Keywords", "Day of Week",
                  "Is Lifestyle", "Is Entertainment",
                  "Is Business", "Is SocMed", "Is Tech",
                  "Is World", "Rate Positive", "Rate Negative"]

DAYS_OF_WEEK = ["Monday", "Tuesday", "Wednesday", "Thursday",
                "Friday", "Saturday", "Sunday"]
CATEGORIES = ["Lifestyle", "Entertainment", "Business", "SocMed", "Tech", "World"]

def analyze_effect_of_weekday(weekday_data)
    decision_tree = DecisionTree::ID3Tree.new(
        ["Day of Week"],
        weekday_data,
        DEFAULT_CLASSIFICATION,
        :discrete)
    decision_tree.train

    tell_me "#{pad('Day', 10)}  #{pad('Prediction', 10)}"
    tell_me "#{'-' * 10}  #{'-' * 10}"
    DAYS_OF_WEEK.each do |day|
        prediction = decision_tree.predict([day])
        tell_me "#{pad(day,10)}  #{pad(prediction,10)}"
    end
end

def analyze_effect_of_weekday_and_keywords(weekday_keywords_data)
    decision_tree = DecisionTree::ID3Tree.new(
        ["Day of Week", "Keywords"],
        weekday_keywords_data,
        DEFAULT_CLASSIFICATION,
        :discrete)
    decision_tree.train

    tell_me "#{pad('Day', 10)}  #{pad('Keywords', 10)}  #{pad('Prediction', 10)}"
    tell_me "#{'-' * 10}  #{'-' * 10}  #{'-' * 10}"

    DAYS_OF_WEEK.each do |day|
        (1..5).each do |number_keywords|
            prediction = decision_tree.predict([day, number_keywords])
            tell_me "#{pad(day,10)}  #{pad(number_keywords,10)} #{pad(prediction,10)}"   
        end
    end
end

def analyze_category(category_data)
    decision_tree = DecisionTree::ID3Tree.new(
        ["Category", "Day of Week", "Keywords"],
        category_data,
        DEFAULT_CLASSIFICATION,
        :discrete)
    decision_tree.train

    tell_me "#{pad('Category', 14)}  #{pad('Day', 10)}  #{pad('KWs', 3)}  #{pad('Prediction', 10)}"
    tell_me "#{'-' * 14}  #{'-' * 10}  #{'-' * 3}  #{'-' * 10}"
    CATEGORIES.each do |category|
        DAYS_OF_WEEK.each do |day|
            (3..5).each do |number_keywords|
                prediction = decision_tree.predict([category, day, number_keywords])
                tell_me "#{pad(category,14)}  #{pad(day,10)}  #{pad(number_keywords,3)} #{pad(prediction,10)}"
            end   
        end
    end

end

newline
analyze_effect_of_weekday(weekday_data)
newline
analyze_effect_of_weekday_and_keywords(weekday_keywords_data)
newline
analyze_category(category_data)