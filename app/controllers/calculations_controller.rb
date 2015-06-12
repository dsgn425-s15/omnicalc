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

    @character_count_without_spaces = @text.split.map(&:length).reduce(:+)

    @word_count = @text.split.size

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
    @monthlyrate=@apr/1200
    @periods = @years*12

    @monthly_payment = (@principal*@monthlyrate)/(1-(1+@monthlyrate)**(-@periods))

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

    @hours = @minutes/60

    @days = @hours/24

    @weeks = @days/7

    @months = @days/30.4

    @years = @days/365.25

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

    @range = @maximum-@minimum

    @median = (@sorted_numbers[(@sorted_numbers.length-1)/2]+@sorted_numbers[@sorted_numbers.length/2])/2.0

    @sum = @numbers.sum

    @mean = @sum/@count

    @variance = 0
    @numbers.each do |x|
        @variance=@variance+(x-@mean)**2
    end
    @variance=@variance/(@numbers.length)

    #@numbers.inject(0.0) { |variance, x| variance += (x - @mean) ** 2 }/(@numbers.length-1)

    @standard_deviation = Math.sqrt(@variance)

    @freq = @numbers.inject(Hash.new(0)){|h,v| h[v]+=1;h}
    @mode=@numbers.max_by{|v| @freq[v]}
  end
end
