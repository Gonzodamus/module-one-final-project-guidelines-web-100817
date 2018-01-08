#this file is for the user story 2.

def returns_most_sanitary_rest_in_zip_and_cuisine
  food
  zipcode_input = retrive_the_zipcode
  list = cusine_options_in_neighborhood(zipcode_input)
  cuisine_input = retrive_the_cuisine(zipcode_input,list)
  return_winning_restaurant(zipcode_input, cuisine_input)
  puts ""
  return_to_menu_or_exit
end

def limited_cuisine_options_in_neighborhood
  puts "Here are some cuisine optitions in your neighborhood:"
end

def cusine_options_in_neighborhood(zipcode)
  puts ""
  array = Restaurant.cuisine_available_in_zipcode(zipcode).sort
  if array.length >= 9
    restaurant_cuisine_option_printer(array.shift(9))
  end
  array
end

def ask_user_if_they_want_more_options
  puts "If you want more options return 'more options'"
  user_input = gets.chomp
  user_input.downcase == "more options" ? true : false
end

def restaurant_cuisine_option_printer(array)
  puts ""
  array.each_with_index do |value, index|
    if index == 0 || (index) % 3 == 0
      if array.length < index + 3
        if array.length == index + 1
          puts "#{value}"
        else
          puts "#{value}  ||  #{array[index+1]}"
        end
      else
        puts "#{value}  ||  #{array[index + 1]}  ||  #{array[index + 2]}  "
      end
    end
  end
end

def return_winning_restaurant(zipcode, cuisine)
  winning_restaurant = Restaurant.most_sanitary_in_area_by_cuisine(zipcode, cuisine)
  puts "\nRestaurant: #{return_data_format(winning_restaurant.name)} \nLast Inspection Score: #{(winning_restaurant.most_recent_inspection.score)} \n\n"
end

def retrive_the_cuisine(zipcode, list)
  puts "\nEnter in what type of cuisine would you like?\n"
  puts "If you want more options enter 'more options'\n\n"
  cuisine_input = gets.chomp
  while cuisine_input.downcase == "more options" do
    if list.length > 0
      restaurant_cuisine_option_printer(list.shift(9))
      puts "\n\nLook for 'more options' or enter in a cuisine below."
      cuisine_input = gets.chomp
    else
      puts "\n\nThose are all the cuisine options in the area. \nPlease enter a cuisine.\n"
      cuisine_input = gets.chomp
    end
  end
  while !valid_cuisine_type?(cuisine_input, zipcode)
    puts "That is not a valid cuisine type. Please try again."
    cuisine_input = gets.chomp
  end
  cuisine_input
end

def valid_cuisine_type? (cuisine, zipcode)
  Restaurant.cuisine_available_in_zipcode(zipcode).any?{ |word| word.downcase == cuisine.downcase }
end

def retrive_the_zipcode
  puts "What zipcode are you searching for food in?"
  zipcode_input = gets.chomp
   while !valid_zipcode?(zipcode_input)
     zipcode_input = gets.chomp
   end
   zipcode_input
end

def valid_zipcode?(zipcode)
  if zipcode.length != 5
    puts "Your zipcode is not 5 digits. Please reenter.\n"
    false
  else
    Restaurant.zipcodes_of_restuarants.any?{|word| word == zipcode}
  end
end
