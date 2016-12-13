class AddCarts < ActiveRecord::Migration[5.0]
  def change
    create_table(:carts) do |t|
    end

    add_column(:products, :cart_id, :integer)
  end
end
