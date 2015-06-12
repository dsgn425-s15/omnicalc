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

    @spaces = @text.count(" ")

    @no_spaces = @character_count_with_spaces - @spaces

    @character_count_without_spaces = @no_spaces

    @word_count = @text.split.count

    @occurrences = @text.count(@special_word)

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

    @monthly_interest_rate = (@apr/100)/12
    @total_payments = @years*12

    @monthly_payment =@principal*(@monthly_interest_rate/(1-(1+@monthly_interest_rate)**(-@total_payments)))
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

    @seconds = (@ending-@starting).to_i
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = (@days/7).to_f
    @years = @weeks/52
end

def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum-@minimum

    if @count.even?

        @median = ((@sorted_numbers[@count/2]+@sorted_numbers[@count/2-1])/2)

    else

        @median = @sorted_numbers[(@count/2).round]

    end

    @sum = @numbers.sum

    @mean = @sum/@count


    def variance
        running_total = 0
        @numbers.each do |array_value|
            running_total = running_total+(@mean - array_value)**2
        end

        return answer = running_total/@count

    end

    @variance = variance

    @standard_deviation = @variance**0.5

# Thought process:
# sort the array
# create a new array
# push the number of times each value appears into the new array
# for each value in @number array, check how many times it appears
# check what value from @numbers array has a count equal to the max of the values in the new array
# this is the mode

def mode
    counter_array = []

    @sorted_numbers.each do |xyz|
        counter_array.push @sorted_numbers.count(xyz)
    end

    @sorted_numbers.each do |xyz|
        if @sorted_numbers.count(xyz) == counter_array.max
            return xyz
        end

    end

end

@mode = mode

end
end
