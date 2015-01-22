json.array!(@officerships) do |officership|
  json.extract! officership, :id, :event_id, :profile_id, :description
  json.url officership_url(officership, format: :json)
end
