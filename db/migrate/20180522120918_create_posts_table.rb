class CreatePostsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, limit:50
      t.string :text, limit: 1000
    end
    add_reference :posts, :user, foreign_key: true
  end
end
