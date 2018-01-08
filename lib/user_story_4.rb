def restaurants_in_area_that_have_least_violations
  food
  zipcode_input = retrive_the_zipcode
  rest_array = Inspection.resturant_info_of_top_five_inspections_by_zipcode(zipcode_input)
  print_out_list_of_restaurants(rest_array)
  return_to_menu_or_exit
end

def print_out_list_of_restaurants(restaurant_array)
  puts "\nHere are the top restaurants in your location:\n\n"
  if restaurant_array == []
    puts "We do not have any records on inspections in that area code"
  else
    restaurant_array.each_with_index do |restaurant, index|
      puts "#{index + 1}. #{return_data_format(restaurant.name)} | Cuisine: #{restaurant.cuisine} | Last Inspection Score: #{restaurant.most_recent_inspection.score}"
    end
  end
end
