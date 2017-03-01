class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer  :debt_id
      t.integer  :cents
      t.datetime :paid

      t.timestamps
    end
  end
end
