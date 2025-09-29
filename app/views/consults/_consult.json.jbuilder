json.extract! consult, :id, :title, :body, :asked_by, :assigned_to, :status, :created_at, :updated_at
json.url consult_url(consult, format: :json)
