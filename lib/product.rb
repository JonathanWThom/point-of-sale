class Product < ActiveRecord::Base
  belongs_to(:purchase)
  validates(:name, {:presence => true, :length => {:maximum => 20}})
end
