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

    @character_count_without_spaces =@text.gsub(' ','').length

    @word_count = @text.split(/[^-a-zA-Z]/).size

    @occurrences = @text.scan(/\b#{@special_word}\b/).length

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
    @r=@apr/1200
    @n=@r*@principal
    @nper=@years*12
    @d=1-(1+@r)**-@nper
    @monthly_payment = @n/@d.to_f
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
    @months = @days/30
    @years = @days/365.25
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort_by(&:to_i)

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = @count%2 == 1? @sorted_numbers[@count/2]:(@sorted_numbers[@count/2-1]+@sorted_numbers[@count/2]).to_f/2

    @sum = @numbers.inject(0){|accum, i| accum + i }

    @mean = @sum/@count.to_f

    @variance = (@numbers.inject(0){|accum,i| accum +(i-@mean)**2})/(@count).to_f

    @standard_deviation =Math.sqrt(@variance)

    #freqency = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    #@mode = @numbers.max_by { |v| freqency[v] }

    hash = {}
    @numbers.each do |number|
        hash[number] == nil ? hash[number] = 1 : hash[number] += 1
    end
    @mode = @numbers.max_by { |i| hash[i] }

end
end

