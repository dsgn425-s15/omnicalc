class CalculationsController < ApplicationController
def sum(list_of_numbers)
  running_total = 0
  list_of_numbers.each do |number|
    running_total = running_total + number
  end

  return running_total
end

# MEAN
# ====
# To find the mean of a set,
#  - we sum up all the elements
#  - then we divide the sum by the number of elements in the set

def mean(list_of_numbers)
  # Let's re-use the work we did above in the sum method
  return sum(list_of_numbers).to_f/list_of_numbers.length
    
end

# VARIANCE
# ========
# To find the variance of a set,
#  - we find the mean of the set
#  - for each number in the set,
#   - we find the difference between the number and the mean
#   - we square the difference
#  - the variance is the mean of the squared differences

def variance(list_of_numbers)
  # Let's re-use the work we did above in the mean method
  new_list=[]
  set_mean = mean(list_of_numbers)
  list_of_numbers.each do |number|
    diff = number-set_mean
    sqr = diff**2
    new_list.push (sqr)
  end
  return mean(new_list)

end

def median(list_of_numbers)
    sorted = list_of_numbers.sort
    list_length = sorted.count
    if list_length%2 == 0
        return (sorted[list_length/2] + sorted[list_length/2 - 1])/2 
    else
        return sorted[(list_length-1)/2]
    end
end
def mode(list_of_numbers)
    sorted = list_of_numbers.sort
    mode_number = sorted[0]
    occurences = 1
    max_occurences = 1
    for i in 1..(sorted.count-1)
        if sorted[i] == sorted[i-1]
            occurences=occurences+1
            if occurences > max_occurences
                max_occurences = occurences
                mode_number = sorted[i] 
            end
        else
            occurences = 1
        end
    end
    return mode_number
end

# STANDARD DEVIATION
# ==================
# To find the standard deviation of a set,
#  - take the square root of the variance

def standard_deviation(list_of_numbers)

  return variance(list_of_numbers)**0.5

end
  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    text_wo_space = @text.gsub(' ','')

    @character_count_with_spaces = @text.length.to_s

    @character_count_without_spaces = text_wo_space.length.to_s

    @word_count = @text.split(/\s+/).length.to_s

    @occurrences = @text.split.count(@special_word)
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f


    @monthly_payment = (@principal*@apr/1200)/(1-(1+@apr/1200)**(-12*@years))
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max-@numbers.min

    @median = median(@numbers)

    @sum = @numbers.sum

    @mean = mean(@numbers)

    @variance = variance(@numbers)

    @standard_deviation = standard_deviation(@numbers)

    @mode = mode(@numbers)
  end
end
