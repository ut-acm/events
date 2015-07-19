class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :price_model_id
      t.text :cut_code
      t.boolean :enabled

      t.timestamps
    end
  end
end
