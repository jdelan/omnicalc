class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.gsub("\n"," ").gsub("\r","").length

    @character_count_without_spaces = @text.gsub(" ","").gsub("\n"," ").gsub("\r","").length

    @word_count = @text.gsub("\n"," ").gsub("\r","").split.length
    # def array_dups
    array_dups = 0

    # def array_text
    special_word_fixed = @special_word.gsub("\n"," ").gsub("\r","").downcase
    array_text = @text.gsub("\n"," ").gsub("\r","").downcase.split
    array_text.each do |word|
      if word == special_word_fixed
        array_dups = array_dups + 1
      end
    end
    # end
    # end
    @occurrences = array_dups

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
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

    @monthly_payment = (@principal * @apr / 1200) / ((1 - (1 + @apr /1200) ** (-1 * @years * 12)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
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
    @minutes = (@ending - @starting)/60
    @hours = (@ending - @starting)/60/60
    @days = (@ending - @starting)/60/60/24
    @weeks = (@ending - @starting)/60/60/24/7
    @years = (@ending - @starting)/60/60/24/365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.sort[0]

    @maximum = @numbers.sort.reverse[0]

    @range = @numbers.sort.reverse[0] - @numbers.sort[0]


    if @numbers.count % 2 == 0
      median_fixed = (@sorted_numbers[@sorted_numbers.count/2 - 1] + @sorted_numbers[@sorted_numbers.count/2]) / 2
    else median_fixed = @sorted_numbers[@sorted_numbers.count/2]
    end


    @median = median_fixed

    @sum = @numbers.sum

    @mean = @numbers.sum/@numbers.count


    mean = @numbers.sum/@numbers.count
    variance = 0
    @numbers.each do |value|
    variance = variance + (value - mean)**2
  end
    variance = variance/@numbers.count
    @variance = variance


    @standard_deviation = variance**(0.5)

freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = @numbers.max_by { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
