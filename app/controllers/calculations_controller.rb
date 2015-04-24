class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @character_count_with_spaces - @text.count(" ")

    @word_count = @text.split(' ').count

    @occurrences = @text.downcase.scan(@special_word.downcase).count

end

def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@principal*(@apr/100/12))/(1-(1+@apr/100/12)**-(@years*12))
end

def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @months =@days/30
    # months not showing
    @years = @days/365
end

def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================


    @sorted_numbers = @numbers.sort_by(&:to_i)

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = median_array_of_numbers(@sorted_numbers)

    @sum = @numbers.reduce(:+)

    @mean = @sum/@count

    @variance = variance_calc(@numbers)

    @standard_deviation = std_dev_calc(@numbers)

    @mode = mode_calc(@numbers)



end


# # mode_calc code

def mode_calc(input_array)
  count = Hash.new(0)
  input_array.each do |number|
    count[number] +=1
  end
  return count.sort_by { |k,v| v}.last.shift
end
  # shift drops the # of occurences from the return string


# # median_calc code
def median_array_of_numbers(input_array)
  if input_array.length % 2 !=0
     median_position = input_array.length / 2
  return input_array[median_position]
  else
      first_position = input_array.length / 2
      second_position = (input_array.length / 2) - 1
      median_value = (input_array[first_position] + input_array[second_position])/2
  return median_value

      #  5 4 2 6 10 1 -- sorted input
      #  1 2 4 5 6 10
       # (4+5)/2. need postion 2 and position 3
       #  length of array = 6. (6/2) & (6/2-1)

  end
end


# # variance_calc and std_dev_calc code

def variance_calc(list_of_numbers)
   mean = @mean
   running_total = 0
   list_of_numbers.each do |number|
      diff = mean - number
      square = diff**2
      running_total = running_total + square
  end
  return running_total / list_of_numbers.length
end


def std_dev_calc(list_of_numbers)
  return Math.sqrt((variance_calc(list_of_numbers).to_f))
end

end



