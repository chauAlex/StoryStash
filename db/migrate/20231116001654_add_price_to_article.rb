class AddPriceToArticle < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :price, :integer
  end
end
