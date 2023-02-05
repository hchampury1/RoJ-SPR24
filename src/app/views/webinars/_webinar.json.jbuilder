json.extract! webinar, :id, :webinar_name, :description, :date, :time, :created_at, :updated_at
json.url webinar_url(webinar, format: :json)
