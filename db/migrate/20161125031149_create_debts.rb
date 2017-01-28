class CreateDebts < ActiveRecord::Migration[5.0]
  def change
    create_table :debts do |t|
      t.integer :user_id
      t.integer :bill_id
      t.datetime :paid

      t.timestamps
    end
  end
end
