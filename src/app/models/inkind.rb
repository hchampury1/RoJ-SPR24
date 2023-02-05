class Inkind < ApplicationRecord
    belongs_to :donor

    def self.to_csv
        attributes = %w{Name Date Value Description User Genre Donor}
        CSV.generate(headers: true) do |csv|
          csv << attributes
          all.each do |inkind|
            csv << [inkind.name, inkind.date, inkind.value, inkind.description, inkind.user, inkind.genre, inkind.donor_name]
          end
        end
    end
end
