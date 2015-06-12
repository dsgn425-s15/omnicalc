class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - @text.count(' ')

    @word_count=0
    @occurrences=0
    @text.split(' ').each do |word| #loop through each word
        if word.length > 0 then
            @word_count+=1
            if word.upcase==@special_word.upcase then
                @occurrences+=1
            end
        end
    end
end

def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    rate = @apr/100.0/12.0  #covert apr (as percent) to monthly interest rate (as decimal)
    nper = @years*12.0 #number of monthly payments
    pv = @principal #present value of loan

    #calculate monthly payment
    @monthly_payment = (pv * rate * (1+rate) ** nper) / ((1+rate)**nper -1)
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
    if (@starting == nil or @ending == nil) then
        return
    end
    @seconds = @ending-@starting
    @minutes = @seconds/60.0
    @hours = @minutes/60.0
    @days = @hours/24.0
    @weeks = @days/7.0
    @years = @days/365.0
end

def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    ##dont continue if there was nothing passed in
    if @count == 0 then
        return
    end

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[-1]

    @range = @maximum-@minimum

    if (@count.to_i % 2)==1 then
        #odd number of elements in array, take the middle element
        @median = @sorted_numbers[@count.to_i/2]
    else
        #even number of elements in array, take mean of middle two elements
        @median = (@sorted_numbers[@count.to_i/2] + @sorted_numbers[@count.to_i/2 - 1])/2.0
    end

    #calculating sum and mean
    @sum = 0
    @numbers.each do |num|
        @sum+=num
    end
    @mean = @sum/@count.to_f

    #calculating variance and standard_deviation
    @sse = 0
    @numbers.each do |num|
        @sse+= (num-@mean) **2  #calculate sum of squared errors
    end
    @variance = @sse / (@count)
    @standard_deviation = Math.sqrt(@variance)

    #calculating mode - method #1: scanning the sorted array
    current_number=0
    current_number_count =0
    best_mode=0
    best_mode_count=0
    @sorted_numbers.each do |new_num|
        if new_num == current_number then
            #increment running total for this number
            current_number_count+=1
        else
            #reset running total for this number
            current_number = new_num
            current_number_count = 1
        end
        #check if we beat the old mode
        if current_number_count >= best_mode_count then
            best_mode = current_number
            best_mode_count = current_number_count
        end
    end
    @mode = best_mode

end

end
