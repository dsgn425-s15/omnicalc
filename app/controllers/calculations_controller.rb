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

    @character_count_without_spaces = @text.strip.length

    @word_count =  @text.split(' ').length



    # @occurrences = @special_word.map {|str| str.count(@text) }
    
    # @occurrences = countOccurence(@text, @special_word)
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



    @monthly_payment = pmt(@apr, @years, @principal)


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

    @seconds = (@starting - @ending).seconds
    @minutes = (@starting - @ending)/60.to_i
    @hours = (@starting - @ending)/60/60.to_i
    @days = (@starting - @ending)/60/60/24.to_i
    @weeks = (@starting - @ending)/60/60/24/7.to_i
    @years = (@starting - @ending)/60/60/24/7/52.to_i
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = minimum(@numbers)

    @maximum = maxNum(@numbers)


    @range = range(@numbers)

    @median = median(@numbers)

    @sum = sum(@numbers)

    @mean = average(@numbers)

    @variance = variance(@numbers)

    @standard_deviation = sd(@numbers)

    @mode = mode(@numbers)
  end


    def pmt(rate, nper, pv)

        dividedRate    = (rate /100/ 12) 
        monthyPayments = nper * 12

        # return (dividedRate * pv) / ( 1 - ((1 + dividedRate) ** - dividedRate))
        return (dividedRate * pv) / (1 - (1 + dividedRate)** - monthyPayments)


    end



    def maxNum(list_of_numbers)
        running_total = 0
        list_of_numbers.each do |number|
        if number > running_total
        running_total = number
        end 

    end
        return running_total
    end


    def minimum(list_of_numbers)
        running_total = 0
        list_of_numbers.each do |number|
        if running_total == 0 
            running_total = number 
        elsif number < running_total
        running_total = number
        end 

    end
        return running_total
    end

  
    def range(list_of_numbers)

        highNum = maxNum(list_of_numbers)
        lowNum  = minimum(list_of_numbers)

        return highNum - lowNum
    end


    def median(array)
      array.sort!
      if array.length % 2 == 0
        median_value = (array[array.length / 2] + array[array.length/2 - 1]) / 2.0
      else
        median_value = array[array.length / 2]
      end
    end

    def sum(list_of_numbers)
    running_total = 0
    list_of_numbers.each do |number|
    running_total = running_total + number
    end
    return running_total

end


    def average(list_of_numbers)

        len = list_of_numbers.length
        sum = sum(list_of_numbers)

    return  sum / len 

    end 

    def variance(list_of_numbers)
    running_total = 0
    average       = average(list_of_numbers)

    list_of_numbers.each do |number|
    running_total = (number - average)**2 + running_total
    end
    return running_total

end

    def sd(list_of_numbers)

        varianceVar = variance(list_of_numbers)
   
    return  varianceVar ** 0.5 

    end 

    def mode(mode)
        mode_return = mode.inject({}) { |k, v| k[v] = mode.count(v); k }
        return mode_return.select { |k,v| v == mode_return.values.max }.keys
        
    end

    def countOccurence(text,special_word)

    newArray = text.select { |a| a == special_word }     
    return newArray.count

    end 


end 