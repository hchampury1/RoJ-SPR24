# Project name: AMSTR (ACCR System Management Tracker)
# Description: Pro-Bono Tracker for ACCR to oversee work done on several cases
# Filename: statistics_controller.rb
# Description: Handles routing for Statistics
# Last modified on: 4/13/22

class StatisticsController < ApplicationController
  # Routes to the index page for statistics view
  def index
    # This returns the top categories by total value of work from
    # the category view
    @categories = CategoryView.where(user_id: current_user.id)
  end
end
