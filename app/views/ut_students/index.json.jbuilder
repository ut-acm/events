json.array!(@ut_students) do |ut_student|
  json.extract! ut_student, :id, :email, :token, :validated
  json.url ut_student_url(ut_student, format: :json)
end
