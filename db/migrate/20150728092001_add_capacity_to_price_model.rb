class AddCapacityToPriceModel < ActiveRecord::Migration
  def change
  	add_column :price_models, :capacity, :integer
  end
end
