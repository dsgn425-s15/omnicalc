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

    #Established the " ", first, then subtracted this # from the previous result
    space_count = @text.count " "

    @character_count_without_spaces = @text.length - space_count

    @word_count = @text.split(/\w+/).length

    #"scans" the first chunk of the text and looks for the special stuff
    @occurrences = @text.scan(/\w+/).count(@special_word)
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
    @epr = @apr/1200.to_f
    @periods = @years*12.to_i

    @monthly_payment = (((1+@epr)**@periods)*@principal*@epr)/(((1+@epr)**@periods)-1)
    
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
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @sum = @numbers.inject{|sum,x| sum+x}

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    def median (numbers)
        sorted_numbers = numbers.sort
        length_of_array = numbers.length
        return (sorted_numbers[length_of_array -1)/2] + sorted_numbers[length_of_array / 2]) / 2
    end

    @median = median(@numbers)

    @mean = @sum / @count

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."
  end
end
