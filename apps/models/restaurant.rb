class Restaurant < ActiveRecord::Base
  has_many :inspections
  has_many :violations, through: :inspections

########## Ryan's Section ############
  def self.most_sanitary_in_area_by_cuisine(zipcode, cuisine)
    in_area = self.restaurant_type_in_zip(zipcode,cuisine)
    last_inspections = {}
    in_area.each do |obj|
      last_inspect = obj.most_recent_inspection
      last_inspections[last_inspect.id] = last_inspect.score
    end
    restaurant_id = [last_inspections.min_by{|k, v| v}].to_h.keys[0]
    self.find(restaurant_id)
  end

  def self.restaurant_type_in_zip(zipcode,cuisine)
    self.where(zipcode: zipcode).where(cuisine: cuisine)
  end

  def self.most_populated_zip_of_cuisine(cuisine)
    x = self.where(cuisine: cuisine).group(:zipcode).count
    x.sort_by { |name, age| age }
  end

  def self.zipcodes_of_restuarants
    self.all.map{ |obj| obj.zipcode }.uniq
  end

  def self.different_types_of_cuisines
    self.all.map{ |obj| obj.cuisine }.uniq
  end

  def self.cuisine_available_in_zipcode (zipcode)
    self.where(zipcode: zipcode).map{ |obj| obj.cuisine }.uniq
  end

######### Ryan's section ending ###################


## Dick's Section Begins Here ##
def address
 "#{self.building} #{self.street} #{self.zipcode}"
end

def self.find_latest_inspection_by_name_and_zipcode(name, zipcode)
  restaurant = Restaurant.find_by(name: name, zipcode: zipcode)
  if restaurant == nil
    "No records found. Please check the restaurant name and zipcode and try again."
  else
  "The restaurants last inspection was on #{Date.parse(restaurant.inspections[0].inspection_date)}
    Its score was #{restaurant.inspections[0].score}.
    Its grade was #{restaurant.inspections[0].grade}."
  end
end


def self.find_restaurant_by_zipcode(zipcode)
  Restaurant.where(zipcode: zipcode)
end


## Not Finished, but in progress ##
def most_recent_inspection_date
  self.inspections.maximum(:inspection_date)
end

def most_recent_inspection
  last_date = most_recent_inspection_date
  self.inspections.where(inspection_date:last_date).first
end

def violation_codes_from_most_recent_inspection
  violation_array = self.most_recent_inspection.violations
  violation_array.map {|violation| violation.violation_code}
end


def self.find_rodents_by_zipcode(zipcode)
  restaurants_in_zip = find_restaurant_by_zipcode(zipcode)
  rodent_violation_codes = ["08A", "04L", "04K"]
  restaurants_with_rodents = restaurants_in_zip.select do |restaurant|
    restaurant.violation_codes_from_most_recent_inspection & rodent_violation_codes != []
  end
  restaurants_with_rodents.map {|restaurant| "#{restaurant.name}, #{restaurant.address}"}
end
## Dick's Section Ends Here ##




end
