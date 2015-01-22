class CreateWorldcups < ActiveRecord::Migration
  def change
    create_table :worldcups do |t|
      t.references :profile, index: true
      t.integer :germany_goal
      t.integer :argentina_goal

      t.timestamps
    end
  end
end
