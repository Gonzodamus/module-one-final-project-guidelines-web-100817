def user_story_three
  puts rat
  puts ""
  puts Inspection.find_rodents_by_zipcode(gets_rodent_zip)
  return_to_menu_or_exit
end


def gets_rodent_zip
  puts "Enter the zip code that you'd like a rodent report for."
  zipcode_input = gets.chomp
   while !valid_zipcode?(zipcode_input)
     zipcode_input = gets.chomp
   end
   zipcode_input
end
