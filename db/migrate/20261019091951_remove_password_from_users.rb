class RemovePasswordFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :password, :string, null: false
  end
end
