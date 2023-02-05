class Webinar < ApplicationRecord
  has_and_belongs_to_many :registrants

  def start_time
    self.date_and_time
  end
end
