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

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split.size

    @occurrences = @text.upcase.scan(@special_word.upcase).length
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
    monthly_rate = @apr / 100 / 12
    months = @years * 12

    payment = (monthly_rate/(1-((1.0+monthly_rate)**(-months)))) * @principal

    @monthly_payment = payment.to_s
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
    @minutes = @seconds / 60.0
    @hours = @minutes / 60.0
    @days = @hours / 24.0
    @weeks = @days / 7.0
    @years = @days / 365.25
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = (@sorted_numbers[(@count - 1) / 2] + @sorted_numbers[@count / 2]) / 2.0

    @sum = @numbers.inject(:+)

    @mean = @sum / @count.to_f

    var_sum = @numbers.inject(0){|temp_sum, i| temp_sum +(i-@mean)**2 }

    @variance = var_sum / (@count).to_f

    @standard_deviation = Math::sqrt(@variance)

    mode_hash = {}
    @numbers.each do |number|
        mode_hash[number] == nil ? mode_hash[number] = 1 : mode_hash[number] += 1
    end
    @mode = @numbers.max_by { |v| mode_hash[v] }
  end
end
