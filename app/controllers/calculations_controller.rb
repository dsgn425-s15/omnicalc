class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]
    @character_count_with_spaces = @text.length
    space_count = @text.scan(' ').count
    @character_count_without_spaces = @text.length - space_count
    @word_count = @text.split.size
    @occurrences = @text.upcase.scan(@special_word.upcase).count
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    rate = @apr/100
    @monthly_payment = (@principal*rate)/(1-(1+rate)**(-@years))
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])
    total_seconds = @ending - @starting
    total_seconds = total_seconds.to_i
    seconds_years = 60*60*24*365
    seconds_week = 60*60*24*7
    seconds_day = 60*60*24
    seconds_hours = 60*60

    @seconds = (((((total_seconds%seconds_years)%seconds_week)%seconds_day)%seconds_hours)%60)/60
    @minutes = ((((total_seconds%seconds_years)%seconds_week)%seconds_day)%seconds_hours)/60
    @hours = (((total_seconds%seconds_years)%seconds_week)%seconds_day)/seconds_hours
    @days = ((total_seconds%seconds_years)%seconds_week)/seconds_day
    @weeks = (total_seconds%seconds_years)/seconds_week
    @years = total_seconds /(60*60*24*365)
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)
    # ======================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ======================================================
    puts @numbers
    @sorted_numbers = @numbers.sort
    @count = @numbers.length
    @minimum = @numbers.min
    @maximum = @numbers.max

    @range = @maximum - @minimum
    def median_array(array)
        sorted = array.sort
        length = array.length
        if (length%2)!= 0
            median_num = sorted[length/2]
        else
            median_num = (sorted[length/2]+sorted[(length/2)-1])/2.0
        end
        return median_num
    end
    @median = median_array(@numbers)
    @sum = @numbers.inject{|sum,x| sum + x }
    @mean = @sum/@count

    def sample_variance(array, mean)
      m = mean
      sum = array.inject(0){|accum, i| accum +(i-m)**2 }
      return sum/(@numbers.length - 1).to_f
    end
    @variance = sample_variance(@numbers, @mean)

    def standard_dev(var)
      return Math.sqrt(var)
    end
    @standard_deviation = standard_dev(@variance)

    def mode_num(mode)
      mode_return = mode.inject({}) { |k, v| k[v] = mode.count(v); k }
      mode_return.select { |k,v| v == mode_return.values.max }.keys
    end
    @mode = mode_num(@numbers)

  end
end
