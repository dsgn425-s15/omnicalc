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

    text = @text


    @character_count_without_spaces = @text.tr(" ","").length



    @word_count = @text.split(/\s+/).size
    # Takes the @text string, turns it into an array by eliminating the spaces, and counts the number of entries in the array

    @occurrences = @text.scan(@special_word).size
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

    true_apr = @apr/100
    exponent = -@years*12
    numerator =true_apr *@principal
    denominator= 1-(1+true_apr)**exponent
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

    @seconds = @ending - @starting
    @minutes = (@seconds/60).round
    @hours = @minutes/60
    @days = (@hours/24).round(2)
    @weeks = (@days/7).round(2)
    @years = (@weeks/52).round(1)
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    range_array = @numbers.minmax
    number_count = @numbers.count
    # median_index = ((number_count+1)/2)-1



    @numbers.inject{|result,element|result+element}

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min
    @maximum = @numbers.max

    @range = range_array[1] - range_array[0]
    @median = (@sorted_numbers[(@count-1)/2]+@sorted_numbers[(@count/2)])/2
    @sum = @numbers.inject{|result,element|result+element}
    @mean = (@sum/(@count)).round(2)

    var1 = @numbers.inject(0){|accum, i| accum +(i-@mean)**2 }.round(2)
    @variance = var1.round(2)

    @standard_deviation = Math.sqrt(var1).round(2)

    @mode = @numbers.group_by{|occr|occr}.values.max_by(&:size).first
  end
end
