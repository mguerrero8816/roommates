class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.user, :references
      t.string :cents
      t.string :integer,
      t.string :split
      t.string :integer,
      t.datetime :paid

      t.timestamps
    end
  end
end
