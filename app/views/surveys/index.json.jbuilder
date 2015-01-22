json.array!(@surveys) do |survey|
  json.extract! survey, :id, :text, :text, :text, :text
  json.url survey_url(survey, format: :json)
end
