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

    @character_count_without_spaces = @text.count("a-z") #@text.length - @text.scan(/\b/).size

    @word_count = @text.scan(/\b/).size/2

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

    r = @apr / 1200
    n = @principal * r
    d = 1 - (1 + r)**-(@years * 12)

    @monthly_payment =n / d
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

    @seconds = (@ending - @starting).to_i
    @minutes = ((@ending - @starting) / (60)).to_i
    @hours = ((@ending - @starting) / (60 * 60)).to_i
    @days = ((@ending - @starting) / (60 * 60 * 24)).to_i
    @weeks = ((@ending - @starting) / (60 * 60 * 24 * 7)).round(2)
    @years = ((@ending - @starting) / (60 * 60 * 24 * 365)).round(2)
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

    @range = @numbers.max - @numbers.min

    mid = @numbers.length / 2
    sorted = @numbers.sort
    @median = @numbers.length.odd? ? sorted[mid] : 0.5 * (sorted[mid] + sorted[mid - 1])

    @sum = (@numbers.inject{ |sum, el| sum + el }.to_f).round(2)

    @mean = (@numbers.inject{ |sum, el| sum + el }.to_f / @numbers.size).round(2)

    @variance = @numbers.sample_variance.round(2) #@numbers.inject {|sum, el| sum + (el - @mean)**2}

    @standard_deviation = @numbers.standard_deviation.round(2) #Math.sqrt(@variance).round(2)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = (@numbers.max_by { |v| freq[v] })
  end
end

module Enumerable

    def sum
      self.inject(0){|accum, i| accum + i }
    end

    def mean
      self.sum/self.length.to_f
    end

    def sample_variance
      m = self.mean
      sum = self.inject(0){|accum, i| accum +(i-m)**2 }
      sum/(self.length - 1).to_f
    end

    def standard_deviation
      return Math.sqrt(self.sample_variance)
    end

end
