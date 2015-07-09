class CreatePriceModels < ActiveRecord::Migration
  def change
    create_table :price_models do |t|

      t.timestamps
    end
  end
end
