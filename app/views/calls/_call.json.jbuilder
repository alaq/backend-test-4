json.extract! call, :id, :caller, :status, :callid, :call_duration, :recording_duration, :recording_url, :selection, :created_at, :updated_at
json.url call_url(call, format: :json)
