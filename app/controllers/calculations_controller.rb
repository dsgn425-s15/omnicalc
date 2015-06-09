class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    #count occurences of special word by splitting string into an array and then checking every word to see if it's equal to special_word
    count=0
    @text.split.each do |word|
        if word==@special_word
        count=count+1
        end
    end


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - @text.count(' ')

    @word_count = @text.split.size

    @occurrences = count
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
    p=@principal
    #n=months
    n=@years*12
    #apr in monthly terms
    r=(@apr/100)/12

#PMT = (P*r)/(1-(1+r)^-N)
    pmt = 0.0
    pmt = (p*r)/(1-((1+r)**(-n)))

    @monthly_payment = pmt

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

    #Note, years does not account for leap years..

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365

  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    sorted=@numbers.sort
    len=@numbers.size
    min=sorted.first
    max=sorted.last
    range=max-min
    median= (sorted[(len-1)/2] + sorted[(len/2)])/2.0


    #sum with iteration
    sum=0.0
    @numbers.each do |num|
        sum=sum+num
    end

    #mean
    mean=sum/len

    #Variance
    #start with sum of squares
    ss=0.0
    @numbers.each do |num|
        ss=ss+(mean-num)**2
    end
    variance=ss/len
    stdev=variance**0.5

    #IDEA FOR MODE
    # Get Unique elements of number array
    # Loop Unique array and count number of instances of each unique in the full array
    # Enter the count and the unique number into the sub array or a larger array
    #when loop is done, sort the larger array, then take the last sub array, second element.

    unique=@numbers.uniq
    container=[]
    unique.each do |unq|
        instances=sorted.select{|num| num==unq}
        count=instances.count
        container.push([count,unq])
    end

    mode=container.sort.last[1]

    @sorted_numbers = sorted

    @count = len

    @minimum = min

    @maximum = max

    @range = range

    @median = median

    @sum = sum

    @mean = mean

    @variance = variance

    @standard_deviation = stdev

    @mode = mode

  end
end
