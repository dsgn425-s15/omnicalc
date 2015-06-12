class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.size

    @character_count_without_spaces = @text.size-@text.count(" ")

    @word_count = @text.split.size

    result = Hash.new(0)
    @text.split.each { |word| result[word] += 1 }

    @occurrences =result[@special_word]
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

    monthlyIR = (1+@apr.to_f/100.to_f).to_f ** (1.to_f/12.to_f)-1
    monthlyTerm = @years * 12

    @monthly_payment = @principal * (monthlyIR + (monthlyIR / ((1+monthlyIR)**monthlyTerm-1)))

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
    @years = @weeks/52
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.sort[0]

    @maximum = @numbers.sort[@numbers.length-1]

    @range = @maximum-@minimum

    @median = @numbers.sort[@count/2]

    sum_returner = 0
    @numbers.each do |worker|
        sum_returner += worker
    end

    @sum = sum_returner

    @mean = @sum / @count

    variance_returner = 0
    @numbers.each do |worker|
        variance_returner += (worker-@mean).abs**2
    end

    @variance = variance_returner/@count

    @standard_deviation = @variance ** (1.to_f/2.to_f)


    result = Hash.new(0)
    @numbers.each do |worker|
        result[worker] += 1
    end

    @mode = result.max[0]
  end
end
