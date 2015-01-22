json.array!(@worldcups) do |worldcup|
  json.extract! worldcup, :id, :profile_id, :germany_goal, :argentina_goal
  json.url worldcup_url(worldcup, format: :json)
end
