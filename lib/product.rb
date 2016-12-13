class Product < ActiveRecord::Base
  belongs_to(:purchase)
  validates(:name, {:presence => true, :length => {:maximum => 20}})
  before_save(:uppercase)

  scope(:not_purchased, -> do
    where({:purchased => false})
  end)

  private

  def uppercase
    self.name = name.upcase
  end

end
