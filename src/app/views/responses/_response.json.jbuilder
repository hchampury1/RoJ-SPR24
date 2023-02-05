json.extract! response, :id, :response_sent, :response_message, :date_sent, :created_at, :updated_at
json.url response_url(response, format: :json)
