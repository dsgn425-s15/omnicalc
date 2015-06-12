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

    @character_count_without_spaces = @text.length-@text.count(' ')

    @word_count = @text.split.size

    @occurrences = @text.scan(/#{@special_word}/).count
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


    r = @apr/100/12
    p = @principal
    n = @years*12

    @monthly_payment = (p*r)/(1-(1+r)**-(n))

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


    if @count %2 !=0
        @median = @sorted_numbers[(@count)/2]
    else
        @median = (@sorted_numbers[(@count - 1)/2] + @sorted_numbers[@count/ 2]) / 2.0
end
        @sum = @numbers.sum

        @mean = @sum/@count

        @variance = (@numbers.inject(0) {|s,x| s + (x - @mean)**2})/@count

        @standard_deviation = (@variance)**0.5

        freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        @mode = @numbers.max_by { |v| freq[v] }
    end
end
