class Inkind < ApplicationRecord
  belongs_to :donor

  # Conducts a search on all donations
  class << self
    # Returns the donations that match the search input or else, return nothing
    @_results = []
    def search(query)
      @_results = Inkind.all.to_a

      @_results.delete_if do |result|
        _invalid = true
        [result.name, result.value.to_s, result.date, result.description, result.user, result.genre, result.donor_name].each do |field|
          if (field.downcase.include?(query.downcase.strip))
            _invalid = false
            break
          end
        end
        _invalid
      end
      @_results
    end
  end

  def self.to_csv
    attributes = %w[Name Date Value Description User Genre Donor]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |inkind|
        csv << [inkind.name, inkind.date, inkind.value, inkind.description, inkind.user, inkind.genre, inkind.donor_name]
      end
    end
  end

  # Ensures that the date field is a valid date.
  validates :date, presence: true
  validate :validate_date_format

  # The "presence: true" part ensures that the corresponding field
  # is nonempty. So this should only be done for mandatory fields.
  validates :name, presence: true
  validates :donor_name, presence: true

  private

  # Function to ensure date has actually occurred
  def validate_date_format
    errors.add(:date, "entered has not happened yet") if date.present? && date >= Date.today
  end
end

