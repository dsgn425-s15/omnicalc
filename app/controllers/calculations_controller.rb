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

    @median = median.to_f

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

    @standard_deviation = @variance**(0.5).to_f

def mode(list_of_numbers)

        count_table = []

        list_of_numbers.each do |check|
        count = list_of_numbers.count(check)
        line={:number => check, :count =>count}
    count_table.push (line)

    end
        count_table.sort_by{|element|element[:count]}
        return count_table[@count-1][:number]
end

    @mode = mode(@sorted_numbers)

  end
end


#mode notes:
#I see where you are going with this, but you can't use the @ sign in the middle of a variable name; either at the beginning, to turn it in to an instance variable, or not at all.

#It seems like you are trying to create new variables count_1, count_2, etc with this technique, which is a great idea. But this syntax is not legal.

#Instead, move your count_table = [] line above your .each. Right now, since it is inside, you are resetting it to a blank array every time through the loop. If you create it one time outside the loop, it will grow as you push new elements in to it.

#Then you won't need to deal with incrementing @number yourself. You can get rid of all that and simply do

#count_table.push(line)
#By the way, be careful with your spaces. Never put a space between a method name and its parentheses for arguments. Never put a space between an array/hash and its square brackets for accessing. Also, be careful not to overuse String Interpolation:

#{}"#{check}"
#{}"#{count}"
#etc
#It's just a handy shortcut when you need to add several strings together. In this case, your code is short for:

#{}"" + count.to_s + ""
#But to what purpose? I think you just want to use count and check as is, as numbers.

#Finally, once you have an array of the form

# count_table
#[
#  { :number => 1.0, :count => 3},
#  { :number => 9.0, :count => 1},
#  { :number => 3.0, :count => 9},
#  { :number => 8.0, :count => 1}
#]
#Plain old .sort won't work by itself, because it won't know whether to sort by comparing the :number or the :count. You instead have to do

#count_table.sort_by { |element| element[:count] }
#And remember that it will sort in ascending order, not descending.

