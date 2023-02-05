# Project name: ACCR Pro Bono Breakdown
# Description: This project will keep track of the pro-bono hours that the ACCR staff volunteers.
# Filename: donations_controller.rb 
# Description: Controller that handles the creation, showing, editing, deleting, and searching of all the pro-bono donations
# Last modified on: December 4, 2022

class DonationsController < ApplicationController  
  before_action :set_donation, only: %i[show edit destroy]
  
  #GET /donations/ or /donations.json
  def index
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
  
  #Searches for a certain string based on all pro-bono hour donations
  def donations
    params.permit(:search)

    _searchParam = params[:search]
    if (_searchParam != nil)
      @donations = Donation.search(_searchParam)
    else
      @donations = Donation.all()
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Donation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def donation_params
      params.require(:donation).permit(:lawyername, :caseaddress, :name, :date, :hours, :fees, :description)

      #Meant for separate classes
      #params.require(:donation, :staff, :case).permit(:lawyername, :caseaddress, :casename, :date, :hours, :description)
    end
end
