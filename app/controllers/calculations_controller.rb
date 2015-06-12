class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    temparray = @text.split(" ")

    @word_count = temparray.length

    #@character_count_with_spaces = "Replace this string with your answer."

    @character_count_with_spaces = @text.length

    running_total = 0
        temparray.each do |word|
        temp = word.length
        running_total=running_total + temp
    end
    @character_count_without_spaces = running_total

    #@occurrences = "Replace this string with your answer."

    running_match = 0
        temparray.each do |word|
        if word.downcase == @special_word.downcase
            running_match = running_match + 1
        end
    end
    @occurrences = running_match


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

    apr=@apr/100
    numerator = apr*@principal
    denominator = 1-(1+apr)**(-1*@years)
    #(1-(1+@apr)**(-1*@years)

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
    @hours = (@minutes/60)
    @days = @hours/24
    @weeks = (@days/7).round(2)
    @years = (@days/365).round(3)
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.sort[0]

    @maximum = @numbers.sort.last

    @range = "#@minimum - #@maximum"

    if @count%2 == 1 # if there's an odd number
        pos = (@count+1)/2-1
        @median = @numbers.sort[pos]
    else
        pos1 = @count/2-1
        pos2 = @count/2
        @median = (@numbers.sort[pos1]+@numbers.sort[pos2])/2
    end

    running_total = 0
    @numbers.each do |num|
        running_total = running_total + num
        @sum = running_total
    end

    @mean = (@sum/@count).round(2)

    running_variance = 0
    @numbers.each do |num|
        running_variance = running_variance + ((num-@mean)**2)
    end
    @variance = (running_variance/@count).round(2)

    @standard_deviation = Math.sqrt(@variance).round(2)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = @numbers.max_by { |v| freq[v] }
  end
end
