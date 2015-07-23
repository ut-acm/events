class CreatePayers < ActiveRecord::Migration
  def change
    create_table :payers do |t|
      t.string :name
      t.string :surname
      t.string :mobile
      t.string :email
      t.text :grades_image
      t.string :region_type
      t.integer :exam_regional_rank
      t.integer :exam_overall_rank
      t.string :city
      t.string :school
      t.integer :payment_id

      t.timestamps
    end
  end
end
