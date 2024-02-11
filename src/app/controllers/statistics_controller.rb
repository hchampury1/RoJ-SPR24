# Project name: AMSTR (ACCR System Management Tracker)
# Description: Pro-Bono Tracker for ACCR to oversee work done on several cases
# Filename: statistics_controller.rb
# Description: Handles routing for Statistics
# Last modified on: 4/21/23

class StatisticsController < ApplicationController
  # Routes to the index page for statistics view
  def index
    @donations = Donation.all
  end
end
