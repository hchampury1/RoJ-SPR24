class Registrant < ApplicationRecord
  has_and_belongs_to_many :webinars 
 end
