#Project name: Mapping Justice
#Description: For our ACCR Collaborative Project we have created an interactive map of PA. The map is color coded by cases + death sentences and population.
#The user can hover over a county to view its statistics. Additionally, several counties can be clicked to generate charts
#Filename: map_controller.rb
#Description: The map controller serves web pages and makes the data hashes available to the view
#Last modified on: 3/07/2023

class MapController < ApplicationController
  include MapHelper
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token


def index
  #map helper functions are called to create the hashes
  @county_map = get_county_data()
  @population_color_codings = create_population_hash()
  @cases_color_codings = create_cases_hash()
  @dr_color_codings = create_dr_hash()
  
end

end