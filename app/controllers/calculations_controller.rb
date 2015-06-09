class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    whole_words = []
    whole_words.push @text

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.split(%r{\s*}).size

    @word_count = @text.split.size

    @occurrences = @text.count("@special_word")
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

    @r = @apr / 100

    @monthly_payment = ((@principal * (@r)) / (1 - (( 1 + @r) ** -@years) )) /12

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

    @seconds = (@ending - @starting).to_f
    @minutes = ((@ending - @starting) / 60).to_f
    @hours = ((@ending - @starting) / 60 / 60).to_f
    @days =  ((@ending - @starting) / 60 / 60 / 24).to_f
    @weeks = ((@ending - @starting) / 60 / 60 / 24 / 7).to_f
    @years = ((@ending - @starting) / 60 / 60 / 24 / 365).to_f
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================




    @sorted_numbers = @numbers.sort

    @count = @numbers.size

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @minimum

        @length = @sorted_numbers.length

        @mediannum = (@count / 2) - 1

    @median = @numbers[@mediannum]
    #(@sorted_numbers [(@length - 1) / 2] + @sorted_numbers[@length / 2]) /2.0

    @sum = @numbers.inject(:+)
    #inject{|sum,x| sum + x }

    @mean = @numbers.inject(:+).to_f / @numbers.size

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @numbers.max_by { |v| freq[v] }
  end
end
