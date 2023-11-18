class AddLikesCountToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :likes_count, :integer, default: 0, null: false
  end
end
