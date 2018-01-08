def user_story_one
  puts restaurant_pic
  puts "Enter the name of the restaurant you'd like the report for."
  name = gets.chomp
  puts ""
  puts Restaurant.find_latest_inspection_by_name_and_zipcode(name, gets_story_one_zip)
  puts ""
  return_to_menu_or_exit
end


def gets_story_one_zip
  puts "Enter the zip code that you'd like a report for."
  zipcode_input = gets.chomp
   while !valid_zipcode?(zipcode_input)
     zipcode_input = gets.chomp
   end
   zipcode_input
end

def restaurant_pic
  puts"

|
|       M  M        MMM   MMM        M
|       M  M     7M  M+   MM  M      MM
|       M  M    M .          M MM    MMM
|       MMMM   M M             NZM   MMM
|       MD M   M                 M   MMM
|        D    M M               MIO  MMM
|        D    M M               M M  MM
|        D    M$M                M   M
|        D     M M             M M   M
|        D      M M           M M    M
|        D       M  M       M MM     M
|        D         MMMM MM  M M      M
|
|_________________________________________

  ".cyan
end
