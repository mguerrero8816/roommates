class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :debt_id
      t.integer :cents

      t.timestamps
    end
  end
end
