class Purchase < ActiveRecord::Base
  has_many(:products)

  # scope(:created_between -> do |start_date, end_date|
  #  where({:date_of_purchase => start_date..end_date}
  # end)

  # scope(:created_at -> do
  #   where(:date_of_purchase >=)
  # end)
  #
  # Comment.where(:created_at => @selected_date.beginning_of_day..@selected_date.end_of_day)

  scope(:not_purchased, -> do
    where({:purchased => false})
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
