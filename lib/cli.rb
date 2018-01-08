def restaurant_data_format(name)
  if name != nil
    name.downcase.gsub(/\s+/, "")
  end
end

def return_data_format(name)
  name.split.map{|word| word.downcase.capitalize}.join(" ")
end

def throw_error
  "You have entered an invalid selection."
end


def introduction
  "
   ___________________________________________________________________________
  |           ***********           ***********          ***********          |
  |                                                                           |
  |                                                                           |
  |        Hello, and welcome to HII, the Health Inspection Inspector.        |
  |___________________________________________________________________________|



".blue
end

def menu
  "                  - Your options are as follows -
         1. Find the most recent inspection for a restaurant
         2. Find the most sanitary restaurants in your area
         3. Find all restaurants in your area with rat and rodent violations
         4. Find the most sanitary restaurant in your area by cuisine
            (select your option by number please)"
end

def get_input
  gets.chomp
end

def selection(input)
  "You have selected #{input}"
end

def menu_input(input)
  case input
  when "1"
    system('clear')
    user_story_one
  when "2"
    system('clear')
    restaurants_in_area_that_have_least_violations
  when "3"
    system('clear')
    user_story_three
  when "4"
    system('clear')
    returns_most_sanitary_rest_in_zip_and_cuisine
  else
    puts "That is not a valid selection. Please enter a number 1 - 4"
    puts menu_input(get_input)
  end
end

def runner
  system'clear'
  puts introduction
  puts menu
  puts menu_input(get_input)
end
#
#runner

def option_to_continue_or_exit
  puts menu
  puts menu_input(get_input)
end

def rat
  puts "         __             _,-\"~^\"-.
       _// )      _,-\"~`         `.
     .\" ( /`\"-,-\"`                 ;
    / 6                             ;
   /           ,             ,-\"     ;
  (,__.--.      \           /        ;
   //'   /`-.\   |          |        `._________
     _.-'_/`  )  )--...,,,___\     \-----------,)
   (((\"~` _.-'.-'           __`-.   )         //
         (((\"`             (((---~\"`         //
                                            ((________________".green
end


def return_to_menu_or_exit
  puts "Would you like to return to the menu or exit?"
  puts "Enter \'menu\' or \'exit\'"
  input = gets.chomp
  until input == "exit" || input == "menu" do
    puts "Incomplete command. Please enter either \'menu\' or \'exit\'"
    input = gets.chomp
  end
  if input == "exit"
    puts "\nGoodbye!"
  elsif input == "menu"
    system('clear')
    option_to_continue_or_exit
  end
end
# retreiving zipcode functions

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
    puts "Your zipcode is not 6 digits. Please reenter.\n"
    false
  else
    Restaurant.zipcodes_of_restuarants.any?{|word| word == zipcode}
  end
end

def food
  puts "
       __
      /
   .-/-.
   |'-'|
   |   |
   |   |   .-\"\"\"\"-.
   \\___/  /' .  '. \\   \\|/\\//
         (`-..:...-')  |`\"\"`|
          ;-......-;   |    |
           '------'    \\____/"
  puts ""
end
