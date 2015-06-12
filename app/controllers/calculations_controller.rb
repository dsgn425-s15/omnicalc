class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.strip.length

    @character_count_without_spaces = @text.gsub(" ",'').length

    @word_count = @text.split.size # following code had double space counting issues @character_count_with_spaces - @character_count_without_spaces + 1

    @occurrences = @text.upcase.scan(@special_word.upcase).size
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
    rate = @apr/100
    @monthly_payment = (@principal*rate*(1+rate)**@years)/((1+rate)**@years-1)
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
    @minutes = (@seconds)/60
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

    @count = @numbers.size

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[-1]


    @range = @maximum - @minimum

    if @numbers.size.even?
        mid = @numbers.size/2
        @median = (@sorted_numbers[mid].to_f + @sorted_numbers[mid-1].to_f)/2
    else
      @median = @sorted_numbers[@sorted_numbers.size/2]
    end


    @sum = @numbers.inject(:+)

    @mean = @sum/@numbers.length

    @variance = (@numbers.map{|x| (x.to_f - @mean)**2}.inject(:+))/@numbers.length

    @standard_deviation = Math.sqrt(@variance)


    frequency = @numbers.inject(Hash.new(0)) { |b,c| b[c] += 1; b }

    @mode = @numbers.group_by{|c| frequency[c]}.max.last.uniq

  end
end
