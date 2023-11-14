class AddDefaultValueToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :balance, :integer, :default => 0
  end
end
