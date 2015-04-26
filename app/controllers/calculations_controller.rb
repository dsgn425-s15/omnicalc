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

    spaces = @text.count " "

    @character_count_without_spaces = @character_count_with_spaces - spaces

    @word_count = word_count = spaces + 1

    special_chars = @text.count "#{@special_word}"
    special_word = special_chars.to_i/@special_word.length

    @occurrences = special_word

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

    r=@apr/100/12.to_f
    n =@years*12

    @monthly_payment = (@principal*r/(1-((1+r)**-n)))

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
    @months = @weeks/52*12
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

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers [@count-1]

    @range = @maximum - @minimum

    count_check = @count.odd?

    if count_check == true
      median = @sorted_numbers [(@count+1)/2 - 1].to_i
    else
        left = (@count/2) - 1
        right = left + 1
        median = ((@sorted_numbers [left] + @sorted_numbers[right])/2).to_f
    end

    @median = median

    def sum(list_of_numbers)
        running_total = 0
        list_of_numbers.each do |number|
        running_total = running_total + number
    end

    return running_total
end

    @sum = sum(@sorted_numbers)



    @mean = @sum/@count.to_f

#create an array with the difference between each number and the mean, squared; then sum the array to get average.


def variance(list_of_numbers)

        difference = []
        list_of_numbers.each do |number|
        difference_sq = (number - @mean)**2
        difference.push difference_sq
    end

        running_total = 0
        difference.each do |num|
        running_total = running_total + num

    end

    return running_total/@count
end


    @variance = variance(@sorted_numbers)

    @standard_deviation = @variance**(1/2)

    @mode = "Replace this string with your answer."
  end
end
