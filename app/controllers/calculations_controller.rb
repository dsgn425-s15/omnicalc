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

    split_text = @text.split(" ")

    split_text_chars = 0
    for word in split_text
      split_text_chars += word.length
    end

    @character_count_without_spaces = split_text_chars

    @word_count = split_text.length

    if @special_word == ""
      @occurrences = "No special word entered"
    else
      @occurrences = @text.split(@special_word).length - 1
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

    # What is the monthly payment over (12 * @years) months that results in the same PV? Annuity formula
    @monthly_payment = (@principal*(@apr/12)*((1+@apr/12)**(12*@years)))/((1+@apr/12)**(12*@years)-1)
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
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

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = median(@numbers)

    @sum = sum(@numbers)

    @mean = mean(@numbers)

    @variance = variance(@numbers)

    @standard_deviation = standard_deviation(@numbers)

    @mode = mode(@numbers)
  end

  # Support methods copied from ruby_essentials folder

  # SUM
  # ====
  def sum(list_of_numbers)
    running_total = 0
    list_of_numbers.each do |number|
      running_total = running_total + number
    end

    return running_total
  end

  # MEAN
  # ====
  # To find the mean of a set,
  #  - we sum up all the elements
  #  - then we divide the sum by the number of elements in the set
  def mean(list_of_numbers)
    # Let's re-use the work we did above in the sum method
    calc_mean = sum(list_of_numbers)/(list_of_numbers.length)
    return calc_mean
  end

  # VARIANCE
  # ========
  # To find the variance of a set,
  #  - we find the mean of the set
  #  - for each number in the set,
  #   - we find the difference between the number and the mean
  #   - we square the difference
  #  - the variance is the mean of the squared differences

  def variance(list_of_numbers)
    # Let's re-use the work we did above in the mean method
    array_sqdiff = []

    list_mean = mean(list_of_numbers)
    list_of_numbers.each do |number|
      array_sqdiff.push((number - list_mean)**2)
    end
    return mean(array_sqdiff)
  end

  # STANDARD DEVIATION
  # ==================
  # To find the standard deviation of a set,
  #  - take the square root of the variance

  def standard_deviation(list_of_numbers)
    return variance(list_of_numbers)**0.5
  end

  # MEDIAN
  # ==================
  def median(list_of_numbers)
    sorted = list_of_numbers.sort
    len = sorted.length
    return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end

  # MEDIAN
  # ==================
  def mode(list_of_numbers)
    # Create new array for the number of occurrences of each number
    occ_array = []
    # Go through the list, find the # of occurrences for each number and push it into the occ_array
    list_of_numbers.each do |number|
      num_occ = 0
      list_of_numbers.each do |othernum|
        if number == othernum
          num_occ += 1
        end
      end
      occ_array.push(num_occ)
    end
    # As the twin arrays for numbers and occurrences are equally indexed (e.g. occ_array[1] is the # of occurrences for the second element in list_of_numbers), we can find the max in the latter, retrieve its index and use it to fetch our mode in list_of_numbers
    return list_of_numbers[occ_array.index(occ_array.max)]
  end
end
