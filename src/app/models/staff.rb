# Project name: ACCR Pro Bono Breakdown
# Description: This project will keep track of the pro-bono hours that the ACCR staff volunteers.
# Filename: staff.rb 
# Description: Framework for staff to be aggregated to donation
# Last modified on: November 17, 2022

class Staff < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :donation, optional: true

    validates :lawyername, presence: true
end