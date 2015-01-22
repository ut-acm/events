json.array!(@payments) do |payment|
  json.extract! payment, :id, :amount, :profile_id, :reference_key, :status, :succeed_time
  json.url payment_url(payment, format: :json)
end
