class Purchase < ActiveRecord::Base
  has_many(:products)

  scope(:current_purchase, -> do
    where({:purchased => false})
  end)

  scope(:purchase_history, -> do
    where({:purchased => true})
  end)


  def total
    total = 0
    self.products.each() do |product|
      total += product.price
    end
    total
  end

  def self.purchases_total(day1, day2)
    purchases = Purchase.where(date_of_purchase: day1..day2)
    total = 0
    purchases.each() do |purchase|
      total += purchase.total
    end
    total
  end

end
