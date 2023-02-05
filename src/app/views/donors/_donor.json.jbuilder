json.extract! donor, :id, :name, :email, :phoneNumber, :location, :created_at, :updated_at
json.url donor_url(donor, format: :json)
