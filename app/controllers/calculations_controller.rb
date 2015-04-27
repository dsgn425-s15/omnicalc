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

    @character_count_without_spaces = @text.gsub(/\s+/, "").length

    wordarray = @text.split(/\s+/)
    counter=0
    wordarray.each do |the_word|
        if the_word==@special_word
            counter=counter+1
        end
    end

    @word_count = wordarray.length

    @occurrences = counter
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

    numerator=@apr/100/12*@principal
    denominator=1-(1+@apr/100/12)**(-@years*12)

    @monthly_payment = numerator/denominator
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

    @seconds = @ending-@starting
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

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count-1]

    @range = @maximum-@minimum

    if(@sorted_numbers.length % 2 ==1)
        @median=@sorted_numbers[@sorted_numbers.length/2]
    else
        @median=(@sorted_numbers[@sorted_numbers.length/2]+@sorted_numbers[@sorted_numbers.length/2-1])/2
    end

    @sum=0
    @numbers.each do |the_number|
        @sum+=the_number
    end

    @mean = @sum/@count

    @variance=0
    @numbers.each do |the_number|
        @variance+=(the_number-@mean)**2
    end
    @variance=@variance/@count

    @standard_deviation = Math.sqrt(@variance)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = @numbers.max_by { |v| freq[v] }
end

end
