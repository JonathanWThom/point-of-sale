require('spec_helper')

describe(Purchase) do
  it {should have_many(:products)}

  describe("#total") do
    it("adds the total products") do
      purchase = Purchase.create(:date_of_purchase => Date.today)
      product = purchase.products.create(:name => 'costco_dog', :description => 'description', :price => 3.5, :purchased => true)
      product2 = purchase.products.create(:name => 'seattle_dog', :description => 'description', :price => 4.5, :purchased => true)
      expect(purchase.total).to(eq(8.0))
    end
  end

  describe(".purchases_total") do
    it("adds up purchases between a given date range") do
      purchase = Purchase.create(:date_of_purchase => Date.today)
      purchase1date = purchase.date_of_purchase
      product = purchase.products.create(:name => 'costco_dog', :description => 'description', :price => 3.50, :purchased => true)
      product2 = purchase.products.create(:name => 'seattle_dog', :description => 'description', :price => 4.50, :purchased => true)
      purchase2 = Purchase.create(:date_of_purchase => Date.new(2016, 12, 25))
      purchase2date = purchase2.date_of_purchase
      product3 = purchase2.products.create(:name => 'weener_dog', :description => 'description', :price => 5.5, :purchased => true)
      product4 = purchase2.products.create(:name => 'up_dog', :description => 'description', :price => 4.50, :purchased => true)
      expect(Purchase.purchases_total(purchase1date, purchase2date)).to(eq(18))
    end
  end

  describe(".current_purchase") do
    it("finds the current_purchase") do
      purchase = Purchase.create(:date_of_purchase => Date.today, :purchased => false)
      expect(Purchase.current_purchase).to(eq([purchase]))
    end
  end

  describe(".purchase_history") do
    it("returns all past purchases") do
      purchase = Purchase.create(:date_of_purchase => Date.today, :purchased => true)
      purchase1 = Purchase.create(:date_of_purchase => Date.today, :purchased => true)
      expect(Purchase.purchase_history).to(eq([purchase,purchase1]))
    end
   end
end
