#Project name: Mapping Justice
#Description: For our ACCR Collaborative Project we have created an interactive map of PA. The map is color coded by cases + death sentences and population. 
#The user can hover over a county to view its statistics. Additionally, several counties can be clicked to generate charts
#Filename: map_controller.rb
#Description: The upload controller performs multiple functionalities including allowing the user to download current data and upload new data files. 
#During the upload process, it performs file validation, adds to the current database, and maintains records of previous uploads.
#Last modified on: 4/12/2022

class UploadController < ApplicationController
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

    #This function allows the user to download a copy of the current data for easy viewing as well as modification
    def downloadcsv
        send_file("#{Rails.root}/app/assets/data/map_data.csv",
        filename: "current_data.csv",
        type: "application/csv")
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
end
