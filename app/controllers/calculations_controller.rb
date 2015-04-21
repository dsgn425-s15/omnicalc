class CalculationsController < ApplicationController


  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]



    number_of_spaces = @text.count(' ')

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - number_of_spaces

    @word_count = @text.split.length

    @occurrences = @text.split.count(@special_word.to_s)
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # formula: PMT = (P*r)/(1-(1+r)^-N)

    pmt = (@principal*@apr/100)/(1-(1+@apr/100)**(-1*@years))
    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = pmt.to_s
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
    #@numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)
    @numbers = params[:list_of_numbers].split(',').map(&:to_f)
    #@numbers = params[:list_of_numbers]
    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================


    def sum_me(number_array_to_sum)
        sum = 0
        number_array_to_sum.each do |rolling|
            sum = sum + rolling
        end
    return sum
    end


    @sorted_numbers = @numbers.sort

    @count = @numbers.length


    @minimum = @numbers.sort[0]

    @maximum = @numbers.sort[@numbers.length-1]

    @range = @maximum - @minimum
    numbers_length = @numbers.length
    numbers_length_half = numbers_length/2

    median =''.to_f

    if numbers_length%2 == 0
       median = (@numbers.sort[numbers_length/2] + @numbers.sort[numbers_length/2-1])/2
    end

  if numbers_length%2 == 1
       median = @numbers.sort[numbers_length/2+0.5]
    end

    @median = median
    sum = sum_me(@numbers)




    @sum = sum

    @mean = sum/@numbers.length

    array_for_variance = []
    variance_calc1 = 0
    @numbers.each do |variance_variable|
        variance_calc1 = (variance_variable-@mean)**2
        array_for_variance.push(variance_calc1)
    end

    variance = sum_me(array_for_variance)/array_for_variance.length


    @variance = variance

    @standard_deviation = variance**0.5



    @mode = "Replace this string with your answer."
  end
end
