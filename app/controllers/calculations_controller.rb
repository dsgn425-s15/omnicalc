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

    @character_count_without_spaces = @text.length - @text.count(' ')

    @word_count = (@text.split).count

    @occurrences = (@text.split).count(@special_word)
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
    @rate = @apr/12/100
    @terms = @years*12
    @monthly_payment = @principal*(((1+@rate)**@terms)*@rate)/(((1+@rate)**@terms)-1)
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

    @seconds = (@ending - @starting).round(0)
    @minutes = (@seconds/60).round(0)
    @hours = (@minutes/60).round(1)
    @days = (@hours/24).round(2)
    @weeks = (@days/7).round(2)
    @years = (@days/365).round(2)
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

    @range = @numbers.max - @numbers.min

    def median(array)
        sorted = array.sort
        len = sorted.length
        return ((sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0).to_f
    end

    @median = median(@numbers)

    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end

      return running_total
    end

    @sum = sum(@numbers)

    @mean = (@sum/@count).round(1)

    @variance = (@sum / (@mean-1)).round(2)

    @standard_deviation = (Math.sqrt(@variance)).round(2)

def mode(mode)
  mode_return = mode.inject({}) { |k, v| k[v] = mode.count(v); k }
  mode_return.select { |k,v| v == mode_return.values.max }.keys
end

    @mode = mode(@numbers)
  end
end
