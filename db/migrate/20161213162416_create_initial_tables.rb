class CreateInitialTables < ActiveRecord::Migration[5.0]
  def change
    create_table(:products) do |t|
      t.column(:name, :string)
      t.column(:description, :string)
      t.column(:price, :decimal)
      t.column(:purchased, :boolean)
      t.column(:purchase_id, :integer)
    end

    create_table(:purchases) do |t|
      t.column(:date_of_purchase, :date)
    end
  end
end
