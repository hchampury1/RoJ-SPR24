# Project name: ACCR Pro Bono Breakdown
# Description: This project will keep track of the pro-bono hours that the ACCR staff volunteers.


class DonationsController < ApplicationController
  before_action :set_donation, only: %i[show edit destroy]

  require 'csv'

  helper_method :sort_column, :sort_direction

  #GET /donations/ or /donations.json
  def index
    # Modified 4/26/23 Need a way to defualt sort by most recently added entry
    # @donations = Donation.all().order(created_at: :desc)
    @donations = Donation.all()
    respond_to do |format|
      format.html { redirect_to donation_url(@donations), notice: "CSV done." }
      format.csv { send_data @donations.to_csv, filename: "donations-#{DateTime.now.strftime("%m-%d-%Y-%H:%M")}.csv" }
    end

  end

  #GET /donations/new
  def new
    @donation = Donation.new
  end

  # GET /donations/1 or /donations/1.json
  def show
  end

  def update
    set_donation()
     # Modified 4/22/23
    @donation.update(donation_params)

    respond_to do |format|
      if @donation.save
        format.html { redirect_to donation_url(@donation), notice: "Pro Bono Log has been successfully updated." }
        format.json { render :show, status: :updated, location: @donation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /donations or /donations.json
  def create
    @donation = Donation.new(donation_params)

    respond_to do |format|
      if @donation.save
        format.html { redirect_to donation_url(@donation), notice: "Pro Bono Log has been successfully created." }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1 or /donations/1.json
  def destroy
    @donation.destroy

    respond_to do |format|
      format.html { redirect_to :donations, notice: "Pro Bono Log has been successfully deleted." }
      format.json { head :no_content }
    end
  end

  def donations
    params.permit(:search, :lawyer_name, :service_type, :date_range, :fee_range, :hour_range)

    # Ensure each of the variable names are LOCAl to this function
    _searchParam = params[:search]
    _lawyerParam = params[:lawyer_name]
    _serviceParam = params[:service_type]
    _startDateParam = params[:date_range_start]
    _endDateParam = params[:date_range_end]
    _feeParam = params[:fee_range]
    _hoursParam = params[:hour_range]

    # This is where the filtering logic will take place. Consideration of all attributes to filter by is reflected on the 
    # Pro-bono Hours table. 
    if (_searchParam != nil)
      @donations = Donation.search(_searchParam)
    else
      @donations = @donations.present? ? @donations : Donation.all
      @donations = @donations.all().order(sort_column + ' ' + (sort_direction || "asc"))
    end

    
    # SQL Command to select all the tuples of the lawyernames that fall within the chosen letter range
    # Modified: 04/22/2023
    if !(_lawyerParam.blank?)
      # Final option to include 'Z' entries in filtered table
      if(_lawyerParam[0] == 'U')
        @donations = @donations.where("UPPER(lawyername) >= ?", "#{_lawyerParam[0]}")
      
      # Filter lawyer name column based on listed params
      else
        @donations = @donations.where("UPPER(lawyername) >= ? AND UPPER(lawyername) < ?", "#{_lawyerParam[0]}", "#{_lawyerParam[2].next}")
      end
    end

# Parses a user-selected .csv file and creates Pro Bono donation entries
# Method for importing .csv file came from Yaroslav Shmarov: https://www.youtube.com/watch?v=EJ8FZMLsVVQ
# https://github.com/corsego/88-csv-import/commit/6a6a43687ca5c967e32f3f1772d70f4d480a51ea
def import
  file = params[:file]
  if file.nil?
    return redirect_to new_donation_path, notice: 'Upload a file before hitting submit please'
  else
    return redirect_to donations_path, notice: 'Only CSV please' unless file.content_type == "text/csv"
  end

  file = File.open(file)

  csv = CSV.parse(file, headers: true, col_sep: ",")
  csv.each do |row|
    donation_hash = Hash.new
    donation_hash[:lawyername] = row["Staff Name"]
    donation_hash[:caseaddress] = row["Service Type"]
    donation_hash[:name] = row["Case Name"]
    donation_hash[:date] = row["Date"]
    donation_hash[:hours] = row["Hours"]
    donation_hash[:fees] = row["Fees"]
    donation_hash[:description] = row["Description"]
    Donation.create(donation_hash)
  end

  respond_to do |format|
    format.html { redirect_to donations_path, notice: 'Donations imported!' }
  end
end

# Filter service type column based on listed params
if !(_serviceParam.blank?)
  @donations = @donations.where("caseaddress LIKE ? ", _serviceParam)
end

# Filter date column based on listed params
if !(_startDateParam.blank?) && !(_endDateParam.blank?)
  if (_startDateParam <= _endDateParam)
    @donations = @donations.where("date BETWEEN ? AND ? ", _startDateParam, _endDateParam)
  end
elsif !(_startDateParam.blank?) && (_endDateParam.blank?)
  @donations = @donations.where("date >= ? ", _startDateParam)
elsif (_startDateParam.blank?) && !(_endDateParam.blank?)
  @donations = @donations.where("date <= ? ", _endDateParam)
end

# Filter fee range column based on listed params
if !(_feeParam.blank?)
  if(_feeParam.include?("More than"))
    @donations = @donations.where("fees > 500")
  else
    fee_split = _feeParam.split('-')
    @donations = @donations.where("fees >= ? AND fees <= ?", fee_split[0], fee_split[1]) 
  end
end

# Filter hour range column based on listed params
if !(_hoursParam.blank?)
  if(_hoursParam.include?("More than"))
    @donations = @donations.where("hours > 75")
  else
    hour_split = _hoursParam.split('-')
    @donations = @donations.where("hours >= ? AND hours <= ?", hour_split[0].to_f, hour_split[1].to_f)
  end
end
end

  private

  # Use callbacks to share common setup or constraints between actions.
    def set_donation
      if params[:id].to_i.to_s == params[:id]
        @donation = Donation.find(params[:id])
      else
        redirect_to donations_path, alert: "Sort and Filtering is cleared." #message when data is already unsorted
      end  
    end

    # Only allow a list of trusted parameters through.
    def donation_params
      params.require(:donation).permit(:lawyername, :caseaddress, :name, :date, :hours, :fees, :description)

      #Meant for separate classes
      #params.require(:donation, :staff, :case).permit(:lawyername, :caseaddress, :casename, :date, :hours, :description)
    end

    # Edited 4/26/2023 to use if-elsif-else in an attempt to fix sorting (Not Fixed yet)
    # This function returns the column name to sort by
    def sort_column
      # if @donations.present? && @donations.column_names.include?(params[:sort])
      #   params[:sort]
      # elsif Donation.column_names.include?(params[:sort])
      #   params[:sort]
      # else
      #   "id"
      # end
       @donation = Donation.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    # Modified 3/28/23
    # This function returns the sort direction to sort by
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
    end

    # Modified 3/28/23
    #Clears sorting attributes. Event occurs when the admin clicks on the button to reset sorting.
    def clear_sort
      redirect_to donations_path(sort: "id", direction: "asc")
    end

    # def search_filter
    #   column = caseaddress.to_s
    #   phrase = params[:service_type]
    #   phrase.delete!('^a-zA-Z0-9-@')
    #   phrase = phrase.strip
      
    #   if column.present? && phrase.present? && !(phrase.blank?)
    #     @opportunities = Opportunity.where("#{column} ILIKE ?", "%#{phrase}%")
    #     @search_word = column + " " + phrase
    #   else
    #     @opportunities = []
    #     @search_word = ""
    #   end

    #   # Output to console for testing purposes
    #   puts "-------------->[Here] #{phrase} [Here]<--------------------"
    #   render :index
    # end
end
