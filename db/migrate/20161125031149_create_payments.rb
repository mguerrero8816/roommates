class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :cents
      t.integer :split
      t.integer :user_id
      t.integer :apartment_id
      t.datetime :paid

      t.timestamps
    end
  end
end
