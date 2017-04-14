class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer  :payable_id
      t.string   :payable_type
      t.integer  :cents
      t.boolean  :active, default: true
      t.datetime :paid

      t.timestamps
    end
  end
end
