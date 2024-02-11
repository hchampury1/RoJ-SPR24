
=begin
    Project Name: InKind Donations
    FileName:/home/student5/RoJ-Spr23/src/app/models/inkindentry.rb
    Description: Inkindentry model, with value, description, and hours attributes
    Last Modified: April 26, 2023
=end


class Inkindentry < ApplicationRecord
  belongs_to :inkind

  #data validation for Inkind attributes
  validates :value, presence: true
  validates :description, presence: true
  validates :hours, presence: true, if: -> { inkind.genre == 'service' }
end
