class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :amount
      t.integer :participation_id

      t.timestamps
    end
  end
end
