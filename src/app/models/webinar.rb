=begin
Project name: ACCR Webinar
Description: This project will keep track of the webinars and their respective speakers.
Filename: webinar.rb
Description: Handles creation of the CSV file.
Last modified on: April 22, 2023
=end

class Webinar < ApplicationRecord
  has_and_belongs_to_many :registrants

  def start_time
    self.date_and_time
  end
  def self.to_csv(items = nil)
    attributes = %w{WebinarName Description Date+Time Speaker(s) RegistrantName Email CLEID Deregisterd County Job Listerv Topics } 
    if items.nil?
      items = Webinar.all
    end
    CSV.generate(headers: true) do |csv|
      csv << attributes
      
      items.each do |item|
        speakers = WebinarsSpeaker.select(:speaker_id).where(webinar_id:item.id)
        registrants = RegistrantsWebinar.select(:registrant_id).where(webinar_id:item.id)
        speakersCSV = []
        registrantsCSV = []
        speakers.each do |speaker|
          speakersCSV << Speaker.find_by(id:speaker.speaker_id).name
        end
        csv << [item.webinar_name, item.description, item.date_and_time, speakersCSV]

        registrants.each do |registrant|
          person = Registrant.find_by(id:registrant.registrant_id)
          csv << ["", "", "", "","#{person.first_name} #{person.last_name}", person.email, person.cleID, person.deregistered, person.county, person.job, person.listserv, person.topics ]
        end

      end
    end
  end
  
end
