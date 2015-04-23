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

    @character_count_without_spaces = @character_count_with_spaces - (@text.split(' ').length-1) - (@text.reverse.index(/[^ ]/)) - (@text.index(/[^ ]/))
    # character count with spaces - spaces between words - spaces at end - spaces at beginning

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

  end

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

    # def variance_calc
    #     @numbers.each do |var|
    #         (var-@mean)**2
    #     end
    #     return variance_calc
    # end

    # @variance = variance_calc(@numbers)

# # need to sum the def above and divide by the count
# pine pg 88

    # @standard_deviation = "Replace this string with your answer."

    # @mode = "Replace this string with your answer."
    # count occurences, sort by number and return value of top. tip: make a hash, loop through array with each and create a hash with key value pairs starting at 1. (each number encountered in array is bumped up by 1 again)
    # create hash
    # @numbers.each do |block_variable| end
    # sorted on values. key is another column for a hash variable
     in hash that was number itself and added value that started as 0.
end



