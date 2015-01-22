json.array!(@answers) do |answer|
  json.extract! answer, :id, :integer
  json.url answer_url(answer, format: :json)
end
