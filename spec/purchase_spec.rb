require('spec_helper')

describe(Purchase) do
  it {should have_many(:products)}

  describe("#total") do
    it("adds the total products") do
      purchase = Purchase.create(:date_of_purchase => Date.today)
      product = purchase.products.create(:name => 'costco_dog', :description => 'description', :price => 3.50, :purchased => true)
      product2 = purchase.products.create(:name => 'seattle_dog', :description => 'description', :price => 4.50, :purchased => true)
      expect(purchase.total).to(eq(8.0))
    end
  end
end
