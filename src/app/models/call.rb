# Project name: Call Organizer
# Description: ACCR Management System Tracker 
# Filename: call.rb
# Description: Represents the call log information: handles validation and search function
# Last modified on: 4/20/23

class Call < ApplicationRecord
    
    @fields = [
        "name", "caller_type", "phone_num", "inmate_num", "institution", "location",
        "point_of_contact", "notes", "call_status"
    ]

    # validation for input fields in call form
    validates :name, presence: true, length: { in: 1..80 },
                   format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }
    
    validates :phone_number,
                   format: { with: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/ }, :allow_blank => true

    validates :institution, length: { in: 0..100 }, :allow_blank => true

    validates :location, length: { in: 0..100 }, :allow_blank => true

    validates :notes, length: { maximum: 255 }

    scope :with_name, ->(name) {where("name = ?", name)}
    scope :with_caller_type, ->(caller_type) {where("caller_type = ?", caller_type)}
    scope :with_phone_num, ->(phone_number) {where("phone_number = ?", phone_number)}
    scope :with_inmate_num, ->(inmate_num) {where("inmate_num = ?", inmate_num)}
    scope :with_institution, ->(institution) {where("institution = ?", institution)}
    scope :with_location, ->(location) {where("location = ?", location)}
    scope :with_point_of_contact, ->(point_of_contact) {where("point_of_contact = ?", point_of_contact)}
    scope :with_date, ->(date) {where("date = ?", date)}
    scope :with_notes, ->(notes) {where("notes = ?", notes)}
    scope :with_call_status, ->(call_status) {where("call_status = ?", call_status)}

class << self
  def search(value, date=nil, field=nil)
    @calls = Call.all
    @results = Call.none
    
    if value.present?
      if field == "search" || field.nil?
        @fields.each do |name| 
          @results = @results.or(@calls.send("with_#{name}", value))
        end
      else
        @results = @calls.send("with_#{field}", value)
      end
    end

    if date.present?
      @results = @results.with_date(date.to_date)
    end
    
    if value.blank? && date.blank?
      return @calls
    end

    return @results
  end
end
end 
