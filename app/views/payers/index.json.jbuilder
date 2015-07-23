json.array!(@payers) do |payer|
  json.extract! payer, :id, :name, :surname, :mobile, :email, :grades_image, :region_type, :exam_regional_rank, :exam_overall_rank, :city, :school, :payment_id
  json.url payer_url(payer, format: :json)
end
