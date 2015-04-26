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

# Missing sum of array
    # @newchararray = @text.split.map(&:length).join ' '

    @character_count_without_spaces = @text.split.map(&:length).join ' '.inject(:+)

    @word_count = @text.split(/[^-a-zA-Z]/).size

    @occurrences = @text.scan(@special_word).count

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

    @monthly_payment = @principal * (@apr/100 + (@apr/100)/(((1 + @apr/100)**(@years * 12))-1))
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
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum - @minimum

    if @numbers.length.odd?
        then @median = @sorted_numbers [(@sorted_numbers.length + 1) / 2] - 1
    else  @median = ((@sorted_numbers [(@sorted_numbers.length) / 2] + @sorted_numbers [((@sorted_numbers.length) / 2) + 1]) / 2) - 1
    end

    @sum = @sorted_numbers.inject{|sum,x| sum + x }

    @mean = @sum / @sorted_numbers.length

    @varianceposition = 0

    @variancesum = 0

    while @varianceposition < @sorted_numbers.length do

        @variancesum = ((@sorted_numbers[@varianceposition] - @mean) ** 2) + @variancesum

        @varianceposition = @varianceposition + 1
    end

    @variance = @variancesum /(@sorted_numbers.length - 1)

    @standard_deviation = @variance ** 0.5

    # @modeposition = 0

    # if @sorted_numbers.scan(@modeposition).count

    @freq = @sorted_numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @sorted_numbers.max_by { |v| @freq[v] }
  end
end
