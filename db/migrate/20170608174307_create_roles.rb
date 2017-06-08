class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end

    create_table :role_users do |t|
      t.integer :role_id
      t.integer :user_id

      t.timestamps
    end
  end
end
