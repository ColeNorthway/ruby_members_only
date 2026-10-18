class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.date :date, null: false
      t.string :title, null: false
      t.string :body, null: false

      t.timestamps
    end
  end
end
