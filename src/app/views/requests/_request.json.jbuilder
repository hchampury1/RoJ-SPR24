json.extract! request, :id, :first_name, :last_name, :email, :request, :created_at, :updated_at
json.url request_url(request, format: :json)
