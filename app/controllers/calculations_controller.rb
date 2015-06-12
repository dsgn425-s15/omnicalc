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


    # create text variable with one space as a blank
    @space_char =" "
    @number_of_spaces = @text.scan(@space_char).count
    @character_count_without_spaces = @character_count_with_spaces - @number_of_spaces

    @word_count = @number_of_spaces+1

    # Create temporary variables to normalize the two strings
    @text_UPPPER = @text.upcase
    @special_word_UPPER = @special_word.upcase
    @occurrences = @text_UPPPER.scan(@special_word_UPPER).count
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

    @apr_monthly = (1+@apr/100)**((0.083333333333333))- 1
    @number_of_periods = @years.to_f*12

    @numeratorTEMP = @apr_monthly*((1+@apr_monthly)**@number_of_periods)
    @denominatorTEMP = (1+@apr_monthly)**@number_of_periods-1
    @monthly_payment_value = @principal*(@numeratorTEMP/@denominatorTEMP)

    @monthly_payment = "#{@monthly_payment_value}"
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
    @years = @weeks/52.5
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @sorted_numbers.length

    @minimum = @numbers[1]
    @numbers.each do |current_Num|
        if current_Num < @minimum
            @minimum = current_Num
        end
    end

    @maximum = @numbers[1]
    @numbers.each do |current_Num|
        if current_Num > @maximum
            @maximum = current_Num
        end
    end

    @range = @maximum-@minimum

    #first check if count is even, if it is then average the middle two after it's sorted
    if @count.even?
        @middle_two_numbers_A = @sorted_numbers[@count/2-1].to_f
        @middle_two_numbers_B = @sorted_numbers[(@count/2).to_i].to_f
        @median = (@middle_two_numbers_A+@middle_two_numbers_B)/2
    else
        @median = @sorted_numbers[@count/2.round(1)]
    end

    @current_Sum = 0
    @numbers.each do |current_Num|
        @current_Sum = @current_Sum + current_Num      
    end
    @sum = @current_Sum

    @mean = @current_Sum/@count

    @diffs_square_array = []
    @sorted_numbers.each do |current_Num|
         @squared_diff = (current_Num-@mean)**2
         @diffs_square_array.push(@squared_diff)
    end

    @square_diffs_total = 0.to_f
    @diffs_square_array.each do |current_Num|
         @square_diffs_total = @square_diffs_total + current_Num
    end

    @variance = @square_diffs_total/@diffs_square_array.length

    @standard_deviation = @variance**(0.5)

    ## figuring out mode
    @mode_tracker = 0.to_f
    @mode_current_number_TEMP = 0.to_f
    @mode_current_freq_TEMP = 0.to_f
    @mode_final_number = 0.to_f
    @mode_final_freq = 0.to_f

    @sorted_numbers.each do |current_Num|
        @mode_current_number_TEMP = @sorted_numbers[@mode_tracker]

        @sorted_numbers.each do |temp_Num|
            if temp_Num == @mode_current_number_TEMP
                @mode_current_freq_TEMP =  @mode_current_freq_TEMP + 1
            end
        end

        if @mode_current_freq_TEMP > @mode_final_freq
            @mode_final_freq = @mode_current_freq_TEMP
            @mode_final_number = @mode_current_number_TEMP
        end

        @mode_current_number_TEMP = 0.to_f
        @mode_current_freq_TEMP = 0.to_f
        @mode_tracker = @mode_tracker +1
    end
    @mode = @mode_final_number
  
  end
end
