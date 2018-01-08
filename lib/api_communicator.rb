require 'rest-client'
require 'json'
require 'pry'

def fetch_data_on_restaurants
  restaurants = RestClient.get("https://data.cityofnewyork.us/resource/9w7m-hzhe.json?$limit=350000")
  restaurants_parsed = JSON.parse(restaurants)
end

def create_violations
  data = fetch_data_on_restaurants
  data.map do |x|
    restaurant = Restaurant.find_or_create_by(restaurant_params(x))
    inspection = Inspection.find_or_create_by(inspection_params(x,restaurant))
    inspection.violations << Violation.find_or_create_by(violation_params(x))
  end
end

def restaurant_params(c)
    {
      restaurant_id: c["camis"],
      name: c["dba"],
      cuisine: c["cuisine_description"],
      zipcode: c["zipcode"],
      street: c["street"],
      building: c["building"],
      phone_number: c["phone"]
    }
end

def violation_params(c)
    {
      violation_code: c["violation_code"],
      violation_description: c["violation_description"]
    }
end

def inspection_params(c, restaurant)
      {
        inspection_date: c["inspection_date"],
        inspection_type: c["inspection_type"],
        restaurant: restaurant,
        score: c["score"],
        grade: c["grade"],
        grade_date: c["grade_date"],
        action: c["action"]
      }
end
