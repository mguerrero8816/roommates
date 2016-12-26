class CreateSplitters < ActiveRecord::Migration[5.0]
  def change
    create_table :splitters do |t|
      t.integer :user_id
      t.integer :payment_id

      t.timestamps
    end
  end
end
