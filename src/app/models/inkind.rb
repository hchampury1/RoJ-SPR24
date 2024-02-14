
=begin
    Project Name: InKind Donations
    FileName:/home/student5/RoJ-Spr23/src/app/models/inkind.rb
    Description: Inkind model, with data validation, and nested inkindentries attribute
    Last Modified: April 27, 2023
=end


class Inkind < ApplicationRecord
  belongs_to :donor
  has_many :inkindentries, dependent: :destroy
  accepts_nested_attributes_for :inkindentries

  # TODO: Add length limits for all fields.

  # Ensures that the date field is a valid date.

  validates :date, presence: true
  validate :validate_date_format

  # The "presence: true" part ensures that the corresponding field
  # is nonempty. So this should only be done for mandatory fields.
  validates :name, presence: true
   
  validates :donor_name, presence: true
   
  # csv function that outputs csv
  def self.to_csv
    attributes = %w{Name Date Hours Value Description User Genre Donor}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |inkind|
        #string variables to handle situations with multiple entries and print to csv
        value_str = inkind.inkindentries.map { |donation| donation.value.to_s }.join(';')
        desc_str = inkind.inkindentries.map { |donation| donation.description.to_s }.join(';')
        hours_str = inkind.inkindentries.select { |donation| donation.hours.present? }.map { |donation| donation.hours.to_s }.join(';')
        csv << [inkind.name, inkind.date, hours_str, value_str, desc_str, inkind.user, inkind.genre, inkind.donor_name]
      end
    end
  end

  #function to ensure date has actually occurred
  def validate_date_format
    if date.present? && date >= Date.today
      errors.add(:date, "entered has not happened yet")
    end
  end    
end