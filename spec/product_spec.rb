require('spec_helper')

describe(Product) do
  it {should belong_to(:purchase)}

  it("tests presence of name attribute") do
    product = Product.create(:name => "")
    expect(product.save).to(eq(false))
  end

  it('tests the max length of the name') do
    product = Product.create(:name => 'a'.*(21))
    expect(product.save).to(eq(false))
  end

  it('tests the presence of the description') do
    product = Product.create(:description => '')
    expect(product.save).to(eq(false))
  end

  it('tests the presence of the price') do
    product = Product.create(:price => '')
    expect(product.save).to(eq(false))
  end

  describe('.not_purchased') do
    it('returns a list of products not purchased yet') do
      product = Product.create(:name => 'name', :description => 'description', :purchased => false)
      product2 = Product.create(:name => 'name', :description => 'description', :purchased => false)
      product3 = Product.create(:name => 'name', :description => 'description', :purchased => true)
      expect(Product.not_purchased()).to(eq([product, product2]))
    end
  end
end
