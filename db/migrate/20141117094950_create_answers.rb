class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :answered
      t.integer :profile_id
      t.integer :survey_id
      t.timestamps
    end
  end
end
