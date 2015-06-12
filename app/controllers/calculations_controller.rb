class CalculationsController < ApplicationController




  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]


    @character_count_with_spaces = @text.length
    @character_count_without_spaces = (@text.length-@text.scan(/ /).count)
    @word_count = @text.split(' ').count
    @occurrences = @text.scan(@special_word).count
end





def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f


    @mpr = @apr / 12 / 100
    @period = @years * 12
    @monthly_payment = (@principal*(@mpr*((1+@mpr)**@period)))/(((1+@mpr)**(@period))-1)
end





def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])


    @seconds = (@ending-@starting).to_i
    @minutes = ((@ending-@starting)/60).to_i
    @hours = ((@ending-@starting)/60/60).to_i
    @days = ((@ending-@starting)/60/60/24).to_i
    @weeks = ((@ending-@starting)/60/60/24/7).to_i
    @years = ((@ending-@starting)/60/60/24/7/52).to_i
end





def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    @sorted_numbers = @numbers.sort_by(&:to_i)
    @count = @numbers.count
    @minimum = @numbers.min
    @maximum = @numbers.max
    @range = (@maximum-@minimum)
    @sum = @numbers.inject(:+)
    @mean = (@sum/@count)
    @length = @sorted_numbers.length
    @median = (@sorted_numbers[(@length-1)/2] + @sorted_numbers[(@length-1)/2])/2

    @variance = 0
    @numbers.each do |x|
        @variance=@variance+(x-@mean)**2
    end

    @variance = @variance/@count
    @standard_deviation = Math.sqrt(@variance)
    
    @freq = @numbers.inject(Hash.new(0)){|h,v| h[v]+=1;h}
    @mode = @numbers.max_by{|v| @freq[v]}
    end
end

