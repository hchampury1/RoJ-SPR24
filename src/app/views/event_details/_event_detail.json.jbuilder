json.extract! event_detail, :id, :title, :eventdatetime, :speakers, :description, :created_at, :updated_at
json.url event_detail_url(event_detail, format: :json)
