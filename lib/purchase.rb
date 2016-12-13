class Purchase < ActiveRecord::Base
  has_many(:products)

  def total
    total = 0
    self.products.each() do |product|
      total += product.price
    end
    total
  end
end
