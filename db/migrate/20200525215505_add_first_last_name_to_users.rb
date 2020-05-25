class AddFirstLastNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string, after: :id
    add_column :users, :last_name, :string, after: :first_name
  end
end
