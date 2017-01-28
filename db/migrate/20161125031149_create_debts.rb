class CreateDebts < ActiveRecord::Migration[5.0]
  def change
    create_table :debts do |t|
      t.integer :user_id
      t.integer :bill_id
      t.integer :apartment_id
      t.string :name
      t.integer :cents
      t.datetime :due
      t.datetime :paid

      t.string :type
      t.timestamps
    end
  end
end
