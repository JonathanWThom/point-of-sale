class Product < ActiveRecord::Base
  belongs_to(:purchase)
  validates(:name, {:presence => true, :uniqueness => { case_sensitive: false }, :length => {:maximum => 20}})
  validates(:price, {:presence => true, :format => {:with => /\A\d+(?:\.\d{0,2})?\z/}, :numericality => {:greater_than => 0}})
  validates(:description, {:presence => true})
  before_save(:uppercase)

  scope(:not_purchased, -> do
    where({:purchased => false})
  end)


  private

  def uppercase
    self.name = name.upcase
  end

end

#
