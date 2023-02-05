class RegistrantsWebinar < ApplicationRecord
  belongs_to :registrant
  belongs_to :webinar
end
