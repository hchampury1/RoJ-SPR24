# Project name: Event Calendar
# Description: Provides a calendar view to help defense attorneys schedule their webinars.
# Filename: event_detail.rb
# Description: the the data model for each event detail renndered by the calenndar
# Last modified on: 11/10/2022
class EventDetail < ApplicationRecord

    #uses active record to store one banner image per event detail
    has_one_attached :banner
    
    class MyModel
        ## Other code related to your model lives here
    end

end
