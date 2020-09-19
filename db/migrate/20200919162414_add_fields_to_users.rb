class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_name, :string, null: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :user_role, :string, null: false, default: 'user'

    add_index :users, :last_name
    add_index :users, :first_name
    add_index :users, :user_role
  end
end
