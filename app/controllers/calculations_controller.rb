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

    @character_count_without_spaces = @text.split.join.size

    @word_count = @text.split.size

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

    @monthly_payment = payment(@apr, @principal, @years)
  end

  def payment(rate, bal, term)
      #source http://www.ktechsystems.com/calculating-a-mortgage-payment-and-future-balance-using-ruby/
      #had to change term length
      # Convert annual rate to monthly and make it decimal.
      r = rate / 1200

      # Numerator
      n = r * bal

      # Denominator
      d = 1 - (1 + r)**(-term*12)

      # Calc the monthly payment.
      pmt = n / d
      return pmt
  end

  def time_between
    require 'time'
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

    @range = @maximum - @minimum

    @median = (@sorted_numbers[(@count-1)/2] + @sorted_numbers[@count/2])/2

    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.count

    @variance = variance(@mean, @numbers)

    @standard_deviation = Math.sqrt(@variance)

    @mode = mode(@sorted_numbers)
  end

  def variance(mean, num_array)
    var_array = []
    for i in num_array
        var_array.push((i-mean)**2)
    end
    return var_array.sum / num_array.count
  end

  def mode(num_array)
    mode_hash = Hash.new
    for i in num_array
        if num_array.include? i
            mode_hash[i] = mode_hash[i].to_i + 1
        else
            mode_hash.store(i, 1)
        end
    end
    largest_hash_key(mode_hash)[0]
  end

  def largest_hash_key(hash)
    hash.max_by{|k,v| v}
  end

end
