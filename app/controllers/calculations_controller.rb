class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

@character_count_with_spaces = @text.length
@character_count_without_spaces = @text.delete(' ').length

    @word_count = @text.split.size

    @occurrences = @text.scan(@special_word).length
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    @monthly_payment = @apr/100/12*@principal/(1-(1+@apr/100/12)**(-@years*12))
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    @seconds = @ending-@starting
    @minutes = ((@seconds)/60).round(2)
    @hours = (@minutes/60).round(2)
    @days = (@hours/24).round(2)
    @weeks = (@days/7).round(2)
    @years = (@days/365).round(2)
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

sorted = @numbers.sort

    @sorted_numbers = sorted

    @count = @numbers.length

    @minimum = sorted.at(0)

    @maximum = sorted.at(-1)

    @range = sorted.at(-1)-sorted.at(0)



    @median = (sorted[(sorted.length - 1) / 2] + sorted[sorted.length / 2]) / 2.0

    @sum = @numbers.inject(:+)

    @mean = @numbers.inject(:+)/@numbers.length

@variance = 0
for i in 0..(@numbers.length-1)
@variance += (@numbers[i] - @mean)**2
end


    @standard_deviation = Math.sqrt(@variance).round(2)

freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @numbers.max_by {|v| freq[v]}
  end
end
