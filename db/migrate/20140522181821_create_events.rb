class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :null => false
      t.string :sentence
      t.text :description
      t.text :summary
      t.datetime :begins
      t.string :venue
      t.string :category
      t.integer :capacity
      t.integer :price
      t.attachment :poster
      t.integer :report_id
      t.timestamps
    end
  end
end
