class Cart < ActiveRecord::Base
  has_many(:products)
end
