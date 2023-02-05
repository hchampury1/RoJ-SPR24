# Project name: AMSTR
# Description: ACCR Management System Tracker 
# Filename: searches_controller.rb
# Description: Manages the search controller
# Last modified on: 4/13/22

class SearchesController < ApplicationController

    # listing possible search parameters
    def index
      # searching by description using desc_summary 
      @worklogs = Worklog.search(params[:desc_summary])
    end

    # creating a new search
    def create
        @worklog = Worklog.new(worklog_params)
        if @worklog.save
          redirect_to searches_path
        else
          render :new
        end
    end
end