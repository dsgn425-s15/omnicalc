class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    @character_count_with_spaces = @text.length

    string_no_space = @text.gsub(/\s+/,"")

    @character_count_without_spaces = string_no_space.length

    @word_count = @text.split.count

    special_count = 0
    text_array = @text.split
    text_array.each do |word|
        if word.downcase == @special_word.downcase
          special_count += 1
        end
    end

    # @text.scan(/\w+/).count(@special_word)
    # works but doesn't handle different capitalization

    @occurrences = special_count
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

    p = @principal
    r = (@apr/12)/100
    n = @years*12

    @monthly_payment = ((p*r)*(1+r)**n)/(((1+r)**n)-1)
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

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers.last

    @range = @maximum-@minimum

    median = 0
    if @count%2 == 0
        median = ((@sorted_numbers[@count/2]+@sorted_numbers[(@count/2)-1])/2)
    else
        median = (@sorted_numbers[@count/2])
    end

    @median = median

    sum = 0
    @numbers.each do |number|
        sum = sum + number
    end

    @sum = sum

    @mean = @sum/@count.to_f

    resid_sq = 0
    @numbers.each do |number|
        resid_sq = resid_sq + (number - @mean)**2
    end

    @variance = resid_sq/@count.to_f

    @standard_deviation = @variance**0.5

    @mode = "Replace this string with your answer."
  end
end
