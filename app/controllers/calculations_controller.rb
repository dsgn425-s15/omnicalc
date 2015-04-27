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

    @character_count_without_spaces = @text.length-@text.scan(" ").count

    @word_count = @text.split.size

    @occurrences = @text.scan(@special_word).count

  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    @mpr = @apr / 1200
    @period = @years * 12


    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # P = L[c(1 + c)^n]/[(1 + c)^n - 1]. P is the payment, while L is the loan value;
    # ================================================================================


    @monthly_payment = (@principal*@mpr*((1+@mpr)**@period))/(((1+@mpr)**@period)-1)
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
    @minutes = (@ending - @starting)/60
    @hours = (@ending - @starting)/(60*60)
    @days = (@ending - @starting)/(24*60*60)
    @weeks = (@ending - @starting)*1.64890918315576E-06
    @years = (@ending - @starting)*3.17969067969068E-08
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

        @sorted_numbers = @numbers.map(&:to_i).sort

        @count = @numbers.count

        @minimum = @numbers.min

        @maximum = @numbers.max

        @range = @numbers.length

        def median(numbersArray)
            ascend = numbersArray.sort
            if ascend.length % 2 != 0
                (ascend.length + 1) / 2.0
            else
                ((ascend.length/2.0) + ((ascend.length + 2)/2.0) / 2.0)
            end
        end

        stemedian = median(@numbers)

        @median = stemedian.to_s

        @sum = @numbers.inject{|sum,x| sum + x }

        @mean = @sum/@count

        def variance(numberssArray)
            running_total = 0
            numberssArray.each do |array_value|
                running_total = running_total + (@mean - array_value)**2
            end

            return answer = running_total/@count

        end

        stevariance = variance(@numbers)

        @variance = stevariance.to_s

        @standard_deviation = @variance.to_f**0.5

        @freq = @sorted_numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @sorted_numbers.max_by { |v| @freq[v]}

  end
end




