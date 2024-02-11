class State < ApplicationRecord
    validates :name, presence: true
    validates :abbreviation, presence: true
  
    # Add any relationships or scopes here
  end
  