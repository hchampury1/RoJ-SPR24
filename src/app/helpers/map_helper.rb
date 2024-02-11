#Project name: Mapping Justice
#Description: For our ACCR Collaborative Project we have created an interactive map of PA. The map is color coded by cases + death sentences and population.
#The user can hover over a county to view its statistics. Additionally, several counties can be clicked to generate charts
#Filename: map_helper.rb
#Description: The map helper script provides methods for formatting data structures used by map/index.html.erb
#Last modified on: 3/07/2023

module MapHelper

	#function returns the RGB hex code for a given county by population
	def get_population_color_coding(county)
		county_id = County.where("name='#{county}'").pluck(:id).max()
		population_arr = County.where(id:county_id).pluck(:population)
		population = population_arr[0]
		if population <= 40000
			return "#BFBFFF"
		elsif population <= 75000
			return "#7879FF"
		elsif population <= 200000
			return "#4949FF"
		else 
			return "#0000FF"
		end
	end

	#function returns the RGB hex code for a given county by cases
	def get_case_color_coding(county)
		county_id = County.where("name='#{county}'").pluck(:id).max()
		cur_cases = County.where(id:county_id).pluck(:num_cur_cases)
		cases = cur_cases[0]
		if cases <= 1
			return "#F6BDC0"
		elsif cases <= 3
			return "#F1959B"
		elsif cases <= 5
			return "#EA4C46"
		else 
			return "#DC1C13"
		end
	end

	#function returns the RGB hex code for a given county by dr sentences
	def get_dr_color_coding(county)
		county_id = County.where("name='#{county}'").pluck(:id).max()
		dr = County.where(id:county_id).pluck(:num_dr)
		cdr = dr[0]
		if cdr == 0
			return "#dbedd5"
		elsif cdr <=3
			return "#99c48d"
		elsif cdr <= 7
			return "#5dcc41"
		elsif cdr <= 10
			return "#28b505"
		else
			return "#218a07"
		end
	end

	#function creates the cases and dr sentences color code hash
	def create_cases_hash()
		cases_hash = {}
		counties = County.distinct.pluck(:name)
		for county in counties
			cases_hash[county] = get_case_color_coding(county)
		end
		return cases_hash
	end

	#function creates the dr sentences color code hash
	def create_dr_hash()
		dr_hash = {}
		counties = County.distinct.pluck(:name)
		for county in counties
			dr_hash[county] = get_dr_color_coding(county)
		end
		return dr_hash
	end

	#function creates the population color code hash
	def create_population_hash()
		population_hash = {}
		counties = County.distinct.pluck(:name)
		for county in counties
			population_hash[county] = get_population_color_coding(county)
		end
		return population_hash
	end

	#function creates a hash containing the most recent county data
	def get_county_data()
		county_map = {}
		counties = County.all
		counties.each do |county|
			name = county.name
			county_map[name] = county
		end
		return county_map
	end

end