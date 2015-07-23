json.array!(@pay_its) do |pay_it|
  json.extract! pay_it, :id, :name, :surname, :mobile, :email, :grades_image, :region_type, :exam_regional_rank, :exam_overall_rank, :city, :school, :payment_id
  json.url pay_it_url(pay_it, format: :json)
end
