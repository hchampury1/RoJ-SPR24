json.extract! donation, :id, :name, :date, :value, :description, :user, :genre, :donor, :created_at, :updated_at
json.url donation_url(donation, format: :json)
