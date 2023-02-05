json.extract! registrant, :id, :first_name, :last_name, :email, :webinar, :county, :job, :listserv, :topics, :created_at, :updated_at

json.url registrant_url(registrant, format: :json)
