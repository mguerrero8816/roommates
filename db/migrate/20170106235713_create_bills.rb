class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.integer :payment_id
      t.integer :apartment_id
      t.string :name
      t.integer :cents
      t.datetime :due

      t.timestamps
    end
  end
end
