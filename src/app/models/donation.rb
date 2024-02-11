# Project name: ACCR Pro Bono Breakdown
# Description: This project will keep track of the pro-bono hours that the ACCR staff volunteers.
# Filename: donation.rb 
# Description: Contains a search functionality for a donation along with the ability to export as a CSV
# Last modified on: December 4, 2022

class Donation < ApplicationRecord
  #Meant for the future aggregation of donation with case and staff
  #has_many :case
  #has_many :staff  

  #Validates the needed attribute values to ensure that they are properly filled out in the donation form
  validates :lawyername, presence: true, length: { in: 3..80 },
  format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

  validates :caseaddress, presence: true, length: { in: 3..80 },
  format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

  validates :name, presence: true, length: { in: 3..80 },
  format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

  validate :date, :valid_date

  validates :hours, presence: true, numericality: { greater_than: 0, less_than: 5000}, 
  format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

  validates :fees, presence: true, numericality: { greater_than: 0, less_than: 5000}, 
  format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

  #Conducts a search on all donations
  class << self
    #Returns the donations that match the search input or else, return nothing
    @_results = []
    def search(query)
      @_results = Donation.all.to_a

      
      @_results.delete_if do |result|
        _invalid = true
        [ result.lawyername, result.caseaddress, result.name, result.description ].each do |field|
            if (field.downcase.include?(query.downcase.strip)) then
                _invalid = false
                break
            end
        end

    
        #date search is individual
        if (result.date&.strftime("%m/%d/%Y").include?(query.downcase.strip)) then
          _invalid = false
        end
        _invalid
      end
      @_results
    end

    

  end

  #method meant to compile all donations and export them all into a CSV file
  def self.to_csv
    attributes = %w{Lawyer_Name Service_Type Case_Name Date Hours Fees Description Created_at Updated_at}
    data = Donation.all.to_a
    #if !(@_results.is_a?(NilClass)) then
     # data = @_results
    #end
    CSV.generate(headers: true) do |csv|
      csv << attributes
      data.each do |donation|
        csv << [donation.lawyername, donation.caseaddress, donation.name, donation.date, donation.hours, donation.fees, donation.description, donation.created_at]
      end
    end
  end

  private

  #Ensures that the date is not empty
  def valid_date
    if !date.present?
      errors.add(:date, "cannot be an empty field")
    end
  end
end
