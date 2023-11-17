class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.integer :price, default: 0

      t.timestamps
    end
  end
end
