json.array!(@models) do |model|
  json.extract! model, :id, :PayIt, :name, :surname, :mobile, :email, :grades_image, :region_type, :exam_regional_rank, :exam_overall_rank, :city, :school, :payment_id
  json.url model_url(model, format: :json)
end
