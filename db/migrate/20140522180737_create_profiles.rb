class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.string :phone_number
      t.integer :credit, :default => 0
      t.attachment :avatar
      t.references :user, index: true
      t.timestamps
    end
  end
end
