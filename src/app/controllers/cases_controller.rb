# Project name: ACCR Pro Bono Breakdown
# Description: This project will keep track of the pro-bono hours that the ACCR staff volunteers.
# Filename: case_controller.rb 
# Description: Controller that handles the creation, showing, editing, deleting, and searching of all the cases (i.e. case name and case address)
# Last modified on: November 17, 2022

class CaseController < ApplicationController    
    #Below contains framework for the aggregation of case and donation, which is not currently implemented.
    #In this current iteration, we are solely using the donations class that contains all of the necessary information.
    #It is undetermined if this class is necessary, but we will keep it as a placeholder if it needed.
    def new
      @case = Case.new
    end
  
    def show
    end
  
    def edit
    end
  
    def create
      @case = Case.new(case_params)
    end

    private
    # Only allow a list of trusted parameters through.
    def case_params
      params.require(:case).permit(:caseaddress, :name)
    end
end