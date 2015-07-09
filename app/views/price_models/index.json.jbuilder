json.array!(@price_models) do |price_model|
  json.extract! price_model, :id, :price, :name, :event_id
  json.url price_model_url(price_model, format: :json)
end
