class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

# def count_words(@text)
#       words = @text.split(' ')
#       frequency = Hash.new(0)
#       words.each do { |@special_word| frequency[@special_word.downcase] += 1 }
#       return frequency
#   end 
    @character_count_with_spaces = @text.size #can also use length instead of size

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split.length #or you can use @text.split(/\s+/).length which then splits everything by a space and ignores spaces
    # clean_text = @text.downcase
    # clean_word = @special_word.downcase
    @occurrences = @text.downcase.scan(/#{@special_word}/).count
    #can also do clean_text.split.count(clean_word)
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

    @monthly_payment = (@apr/1200 + ((@apr/1200)/(((1+@apr/1200)**(@years*12))-1)))*@principal
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
    #raise displays the values                   raise.(@ending-@starting).inspect 

    @seconds =  @ending - @starting
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

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = (@sorted_numbers[(@count - 1) / 2] + @sorted_numbers[@count / 2]) / 2.0

    @sum = @numbers.sum

    @mean = @sum/@count
    #  def sum
    #   self.inject(0){|accum, i| accum + i }
    # end

    # def mean
    #   self.sum/self.length.to_f
    # end

    # def sample_variance
    #   m = self.mean
    #   sum = self.inject(0){|accum, i| accum +(i-m)**2 }
    #   sum/(self.length - 1).to_f
    # end

    # def standard_deviation
    #   return Math.sqrt(self.sample_variance)
    # end

    @variance = @numbers.inject(0){|accum, i| accum +(i-@mean)**2}/(@count-1).to_f

    @standard_deviation = @variance**(0.5)

    @mode = @numbers.max_by{ |v| @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }[v] }  #need to understand hash more and inject - passing through an array
end
end
