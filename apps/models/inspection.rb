class Inspection < ActiveRecord::Base
  belongs_to :restaurant
  has_many :inspection_violations
  has_many :violations, through: :inspection_violations



  # User case 4: this function returns the top 5 restaurants in the zipcode
  def self.resturant_info_of_top_five_inspections_by_zipcode(zipcode)
    array = self.most_recent_inspection_and_minimum_score_in_areacode_limiting_to_15_then_returning(zipcode).take(5)
    array.map { |inspection| inspection.restaurant }
  end

  # helper method
  def self.most_recent_inspection_and_minimum_score_in_areacode_limiting_to_15_then_returning (zipcode)
    self.minimum_score_in_areacode(zipcode).take(30).select {|e| e.most_recent_inspection?}
  end

  def self.inspections_ordered_by_scores
    self.order(:score).where("score IS NOT NULL")
  end

  def self.filter_by_zipcode(zipcode)
    includes(:restaurant).where(restaurants: {zipcode: zipcode})
  end

  def self.minimum_score_in_areacode(zipcode)
    self.filter_by_zipcode(zipcode).inspections_ordered_by_scores
  end

  def self.filter_by_cuisine(cuisine)
    includes(:restaurant).where(restaurants: {cuisine: cuisine})
  end

  def most_recent_inspection?
    self.restaurant.most_recent_inspection == self ? true : false
  end

  def full_violation_codes
    self.violations.map {|violation|violation.violation_code}
  end


 def self.filter_by_inspection_code(code)
   includes(:violations).where(violations: {violation_code: code})
   # "04L", "04K"
 end

 def self.filters_by_two_inspection_codes(code1, code2)
   self.filter_by_inspection_code(code1) || self.filter_by_inspection_code(code2)
 end

 def self.filter_two_inspection_codes_by_zip(zipcode, code1, code2)
   self.filter_by_zipcode(zipcode).filters_by_two_inspection_codes(code1, code2)
 end

 def self.find_restaurants_based_on_list(array)
   array.map{|inspection| inspection.restaurant}.uniq
 end

  def self.find_rodents_by_zipcode(zipcode)
    all_inspections_with_rodents = Inspection.filter_two_inspection_codes_by_zip(zipcode, "04L", "04K")
    restaurants_with_rodents = Inspection.find_restaurants_based_on_list(all_inspections_with_rodents)
    restaurants_with_rodents_alpha = restaurants_with_rodents.sort_by{|restaurant| restaurant.name}
    if restaurants_with_rodents_alpha == []
      "No restaurants with rodents found in #{zipcode}"
    else
      restaurants_with_rodents_alpha.map do |restaurant|
        "#{return_data_format(restaurant.name)}, #{restaurant.address_without_zipcode}"
      end
    end
  end

end
