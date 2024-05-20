#Project name: Mapping Justice
#Description: For our ACCR Collaborative Project we have created an interactive map of PA. The map is color coded by cases + death sentences and population. 
#The user can hover over a county to view its statistics. Additionally, several counties can be clicked to generate charts
#Filename: upload_controller.rb
#Description: The upload controller performs multiple functionalities including allowing the user to download current data and upload new data files. 
#During the upload process, it performs file validation, adds to the current database, and maintains records of previous uploads.
#Last modified on: 4/7/2024

class UploadController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :get_county, only: %i[edit]
    helper_method :sort_column, :sort_direction
    #CONSTANTS definition
    #MAX_UPLOADS indicates the max number of previous file uploads that are kept in storage
    MAX_UPLOADS = 6
    #COUNTIES represents the expected data in the first column of the uploaded data
    COUNTIES = ['Adams', 'Allegheny', 'Armstrong','Beaver','Bedford','Berks','Blair','Bradford','Bucks','Butler','Cambria',
    'Cameron','Carbon','Centre','Chester','Clarion','Clearfield','Clinton','Columbia','Crawford','Cumberland',
    'Dauphin','Delaware','Elk','Erie','Fayette','Forest','Franklin','Fulton','Greene','Huntingdon','Indiana','Jefferson',
    'Juniata','Lackawanna','Lancaster','Lawrence','Lebanon','Lehigh','Luzerne','Lycoming','McKean','Mercer','Mifflin',
    'Monroe','Montgomery','Montour','Northampton','Northumberland','Perry','Philadelphia','Pike','Potter','Schuylkill',
    'Snyder','Somerset','Sullivan','Susquehanna','Tioga','Union','Venango','Warren','Washington','Wayne','Westmoreland','Wyoming',
    'York']   
    #COLUMNS represents the expected values for headers in uploaded data
    COLUMNS = ['name', 'num_cur_cases', 'num_cur_cases_b', 'num_cur_cases_w', 'num_cur_cases_o','population', 'num_dr', 'num_dr_b', 'num_dr_w', 'num_dr_o']
    
    def index
        # Set original counties to data from current session or to all countiess
        @orig_counties = session[:search_results].present? ? County.where(session[:search_results]) : County.all
        
        # Grab values for dropdowns
        @county_names = County.pluck(:name).uniq.sort
        @pop = County.pluck(:population).uniq.sort
        @min_pop = County.pluck(:population).uniq.sort
        @max_pop = County.pluck(:population).uniq.sort
        @totalPend = County.pluck(:num_cur_cases).uniq.sort
        @bPend = County.pluck(:num_cur_cases_b).uniq.sort
        @wPend = County.pluck(:num_cur_cases_w).uniq.sort
        @oPend = County.pluck(:num_cur_cases_o).uniq.sort
        @totalCur = County.pluck(:num_dr).uniq.sort
        @bCase = County.pluck(:num_dr_b).uniq.sort
        @wCase = County.pluck(:num_dr_w).uniq.sort
        @oCase = County.pluck(:num_dr_o).uniq.sort

        # Search parameters
        input = {}
        input[:name] = params[:countyName] if params[:countyName].present?
        input[:population] = params[:pop] if params[:pop].present?
        input[:num_cur_cases_b] = params[:bPend] if params[:bPend].present?
        input[:num_cur_cases_w] = params[:wPend] if params[:wPend].present?
        input[:num_cur_cases_o] = params[:oPend] if params[:oPend].present?
        input[:num_dr] = params[:totalCases] if params[:totalCases].present?
        input[:num_dr_b] = params[:bCase] if params[:bCase].present?
        input[:num_dr_w] = params[:wCase] if params[:wCase].present?
        input[:num_dr_o] = params[:oCase] if params[:oCase].present?
        
        #Saves search parameters
        session[:search_results] = input
        
        # Will filter results base on if search parameters exist
        @search_results = County.all
        @search_results = @search_results.where(input) if input.present?

        # Sorts search results in table
        # Sorts if not input found
        if input.blank? && params[:sort].present? && County.column_names.include?(params[:sort])
            @search_results = @orig_counties.order(sort_column + ' ' + (sort_direction || "asc"))
        end
        # Sorts if input found
        if input.present? && params[:sort].present? && County.column_names.include?(params[:sort])
            @search_results = @search_results.order(sort_column + ' ' + (sort_direction || "asc"))
        end

        # Flashes an alert isf no results
        flash.now[:alert] = "No Results Found!" if @search_results.empty?
        
        render :index
    end
    
    def edit
        get_county()
    end

    def update
        get_county()
        if @county.update_attributes(county_params)
            flash[:notice] = 'County updated!'
            redirect_to upload_index_path
        else
            flash[:error] = 'Failed to edit county'
            render "edit"
        end
    end

    # def destroy
    #     get_county()
    #     @county.destroy
    #     redirect_to upload_index_path, notice: "County has been successfully deleted."
    # end

    #This function allows the user to download a copy of the current data for easy viewing as well as modification
    def downloadcsv
        input = session[:search_results]
        @counties = County.where(input)
        if @counties.nil? || @counties.empty?
            redirect_to upload_index_path
            return
        end
        #Saves data if data fou
        csv_data = CSV.generate(headers: true) do |data|
            data << COLUMNS
            @counties.each do |el|
              data << COLUMNS.map { |col| el[col] }
            end
        end
        #Creates dowmload file
        send_data csv_data, filename: "current_data.csv", type: "application/csv"
    end

    #This function allows the user to upload a csv file with new data for the map. It performs input validations.
    def uploadcsv
        uploaded_io = params[:file]
        #if file passes validation criteria
        if uploaded_io != nil && csv?(uploaded_io) && valid_format?(uploaded_io)
            #upload the file to the server
            file_name = "data_" + Time.now.inspect + ".csv"
            file_path = Rails.root.join('public', 'uploads', file_name)
            file_data = uploaded_io.read
            File.open(file_path, 'wb') do |file|
                file.write(file_data) 
            end
            #Ensure no more than MAX_UPLOADS files are being stored
            uploads_pruner()
            #Add to the database so the map reflects the new data
            change_map_data(file_path)
            #store a copy of the newest map data
            file_name = "map_data.csv"
            file_path = Rails.root.join('app/assets/data', file_name)
            File.open(file_path, 'wb') do |file|
                file.write(file_data) 
            end
            flash[:notice] = "Map Updated Successfully!"  
            redirect_to upload_index_path
        end
    end

    private
    #Returns column name to be sorted
    def sort_column
         @counties = County.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    #Returns sorting direction: ascending or descending
    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
    end

    #This function ensures the file has a .csv extension
    def csv?(file)
        if file.original_filename.ends_with?('.csv')
            return true
        else
            flash[:alert] = "File is not a CSV file"
            redirect_to upload_index_path
            return false
        end 
    end

    #This function ensures the file follows the exact format required to upload new data
    def valid_format?(file_io)
        file = CSV.read(file_io, :headers => true, :converters => :integer)
            #Checking there exists a row for each county in PA
            if file.length != COUNTIES.length
                flash[:alert] = "File needs to have " + String(COUNTIES.length) + " rows. It currently has "+ String(file.length) + " rows."  
                redirect_to upload_index_path
                return false
            end
            #Checking the file headers match those required for file upload
            if file.headers != COLUMNS
                flash[:alert] = "Incorrect column headers in file. Please ensure it follows the format specified." 
                redirect_to upload_index_path
                return false
            end
            #Checking the county names or the value of the primary key of these data rows correspond to those currently in the database
            if file['name'] != COUNTIES
                flash[:alert] = "There is invalid data in the name column. Please ensure it follows the format specified." 
                redirect_to upload_index_path 
                return false
            end
        
            #If any attribute value excluding the name includes values that are non-numeric or not null
            file.each do |row|
                for i in 1..COLUMNS.length - 1  
                    if !(row[i].nil? or row[i].is_a? Integer)   
                        flash[:alert] = "There is invalid data in the " + String(COLUMNS[i]) + " column of row " + row[0] +". Please ensure it only contains integers."
                        redirect_to upload_index_path 
                        return false
                    end
                end
            end
        return true
    end

    #This function changes the data represented by the map. New data is appended to existing data in the database.
    def change_map_data(file_path)
        begin
            @counties = County.all
            @counties.each do |county|
                county.delete
            end
            CSV.foreach(file_path, :headers => true, :encoding => 'ISO-8859-1', :converters => :integer) do |row|
                County.create!(row.to_hash)
            end
        rescue Exception => e
            flash[:alert] = "Update Failed. Error: #{e}"
            redirect_to upload_index_path 
            return
        end
    end

    #This function ensures that only MAX_UPLOADS number of files are stored 
    def uploads_pruner()
        uploads = Dir[Rails.root.join('public','uploads',"*")]
        while uploads.length > MAX_UPLOADS
            File.delete((uploads).min_by{|f| File.mtime(f)})
            uploads = Dir[Rails.root.join('public','uploads',"*")]
        end
    end

    def get_county
        @county = County.find(params[:format])
    end

    def county_params
        params.require(:county).permit(:name, :num_cur_cases, :num_cur_cases_w, :num_cur_cases_b, :num_cur_cases_o, :population, :num_dr, :num_dr_w, :num_dr_b, :num_dr_o)
    end
end