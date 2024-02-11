module WebinarsaboutHelper
    def to_csv
    attributes = %w{Name Date Value Description User Genre Donor}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |webinar|
        if params[:webinar_ids].has_value?(webinar.webinar_id)
          csv << [webinar.name]
        end
      end
    end
    end
end
