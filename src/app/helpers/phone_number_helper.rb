module PhoneNumberHelper
    def format_phone_number(phone_number)
      # Remove any non-digit characters
      formatted_number = phone_number.to_s.gsub(/\D/, '') 
      # Add dashes to phone number
      formatted_number = formatted_number.insert(3, '-').insert(7, '-')
      formatted_number
    end
end