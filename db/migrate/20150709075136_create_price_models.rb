class CreatePriceModels < ActiveRecord::Migration
  def change
    create_table :price_models do |t|
      t.integer :price
      t.string :name
      t.integer :event_id
      t.timestamps
    end
    add_column :paricipations, :price_model_id, :integer
  end
end
