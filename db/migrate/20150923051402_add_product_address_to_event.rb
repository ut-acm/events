class AddProductAddressToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :product_address, :string
  end
end
