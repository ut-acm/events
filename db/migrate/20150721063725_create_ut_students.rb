class CreateUtStudents < ActiveRecord::Migration
  def change
    create_table :ut_students do |t|
      t.string :email
      t.text :token
      t.boolean :validated
      t.integer :user_id

      t.timestamps
    end
  end
end
