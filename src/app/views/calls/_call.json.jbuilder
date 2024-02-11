json.extract! call, :id, :caller_type, :name, :phone_number, :inmate_num, :institution, :location, :point_of_contact, :date, :notes, :created_at, :updated_at, :call_status
json.url call_url(call, format: :json)
