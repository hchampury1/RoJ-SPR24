#Project Name: InKind Donations
#FileName:donor.rb
#Description: Donor model, with data validation
#Last Modified: April 25, 2023

class Donor < ApplicationRecord
  has_many :donation, foreign_key: :donor_name

  # TODO: Add length limits for all fields.

  # TODO: Figure out what the format of "donor_id" is.

  # Validates that the email field is correctly formatted.
  #
  # TODO: Verify what the official rules are for an email format. Eg,
  # are Unicode characters allowed? Can an email be all numbers?
  validates :email, presence: true,
            format: { with: /\A[-_.a-zA-Z0-9]+@[-_.a-zA-Z0-9]+\.[-_.a-zA-Z0-9]+\z/.freeze }

  # The "presence: true" part ensures that the corresponding field
  # is nonempty. So this should only be done for mandatory fields.
 # validates :donor_name, presence: true
  #validates :location, presence: true
  validates :location, presence: true,
            format: { with: /\A[a-zA-Z0-9\s,.-]+\z/.freeze }
  # Validates that the phone number field is correctly formatted.
  #
  # TODO: The input form should display parentheses, hyphens, and
  # spaces.
  #
  # TODO: Allow country code?
  #
  # TODO: For some inexplciable reason, this ignores leading 0s. That
  # is, 0123456789 is rejected, whereas 00000000000001234567890 is
  # accepted. But leading 0s shouldn't matter; the file
  # app/views/donors/_form.html file specifies that it's a text field,
  # not a number field. My guess is that somewhere else in the code (I
  # have no idea where), the string is being converted to an integer.
  validates :phoneNumber, presence: true,
            format: { with: /\A([0-9]{10}|[0-9]{3}-[0-9]{3}-[0-9]{4})\z/.freeze }
end
