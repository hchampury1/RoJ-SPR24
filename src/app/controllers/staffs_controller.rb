# Project name: ACCR Pro Bono Breakdown
# Description: This project will keep track of the pro-bono hours that the ACCR staff volunteers.
# Filename: staffs_controller.rb 
# Description: Controller that handles the creation, showing, editing, deleting, and searching of all the staff (i.e. lawyer name)
# Last modified on: November 17, 2022

class StaffController < ApplicationController      
    #Below contains framework for the aggregation of staff and donation, which is not currently implemented.
    #In this current iteration, we are solely using the donations class that contains all of the necessary information.
    #It is undetermined if this class is necessary, but we will keep it as a placeholder if it needed.  
    def new
        @staff = Staff.new
    end
  
    def show
    end
  
    def edit
    end
  
    def create
        @staff = Staff.new(staff_params)
    end

    def self.show_staff_name(lawyername)
        @staff = Staff.find_by(lawyername: params[:lawyername])
    end

    private
    # Only allow a list of trusted parameters through.
    def staff_params
        params.require(:staff).permit(:lawyername)
    end
end