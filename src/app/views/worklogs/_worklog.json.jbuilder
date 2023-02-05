json.extract! worklog, :id, :user_id, :project_id, :desc_summary, :desc_body, :hours, :fee, :date, :entered_by_id, :created_at, :updated_at
json.url worklog_url(worklog, format: :json)
