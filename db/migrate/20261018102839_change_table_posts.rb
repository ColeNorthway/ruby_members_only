class ChangeTablePosts < ActiveRecord::Migration[8.1]
  def change
    change_table :posts do |t|
      t.belongs_to :user, foreign_key: true, null: false
    end
  end
end
