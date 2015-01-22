json.array!(@class_sessions) do |class_session|
  json.extract! class_session, :id, :event_id, :duration, :start_time
  json.url class_session_url(class_session, format: :json)
end
