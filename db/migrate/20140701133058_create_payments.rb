class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount
      t.integer :profile_id
      t.string :reference_key
      t.boolean :status , default: false
      t.datetime :succeed_time
      t.text :response

      t.timestamps
    end
  end
end
