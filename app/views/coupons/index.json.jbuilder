json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :event_id, :cut_code, :enabled
  json.url coupon_url(coupon, format: :json)
end
