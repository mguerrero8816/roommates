class CreateApartments < ActiveRecord::Migration[5.0]
  def change
    create_table :apartments do |t|
      t.string :name
      t.string :address

      t.timestamps
    end

    create_table :apartment_tenants do |t|
      t.integer :user_id
      t.integer :apartment_id

      t.timestamps
    end
  end
end
