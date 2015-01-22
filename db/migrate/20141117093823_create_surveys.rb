class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.text :question
      t.text :op1
      t.text :op2
      t.text :op3
      t.integer :event_id

      t.timestamps
    end
  end
end
