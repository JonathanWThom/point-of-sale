class AddPurchasedColumn < ActiveRecord::Migration[5.0]
  def change
    add_column(:purchases, :purchased, :boolean)
  end
end
