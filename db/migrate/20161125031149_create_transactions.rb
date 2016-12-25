class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.user :references
      t.integer :cents
      t.integer :split
      t.datetime :due
      t.datetime :paid

      t.timestamps
    end
  end
end
