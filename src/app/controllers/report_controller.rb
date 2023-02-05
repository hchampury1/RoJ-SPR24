# Project name: AMSTR %>
# Description: ACCR Management System Tracker
# Filename: report_controller.rb
# Description: Controller to handle all actions involving the report %>
# Last modified on: 4/13/22

class ReportController < ApplicationController
  def index

    #Only display current user worklog entries in table
    #Admin user can see all worklogs between all users
    @worklogs = Worklog.accessible_by(current_ability).order(:id).page params[:page]
    
  end
end
