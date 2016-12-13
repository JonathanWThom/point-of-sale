require('spec_helper')

describe(Product) do
  it {should belong_to(:purchase)}

  it("tests presence of name attribute") do
    product = Product.create(:name => "", :description => 'blah', :price => 9)
    expect(product.save).to(eq(false))
  end

  it('tests the max length of the name') do
    product = Product.create(:name => 'a'.*(21), :description => 'blah', :price => 9)
    expect(product.save).to(eq(false))
  end

  it('tests the presence of the description') do
    product = Product.create(:description => '', :name =>'name', :price => 9)
    expect(product.save).to(eq(false))
  end

  it('tests the presence of the price') do
    product = Product.create(:price => '', :description => 'description', :name => 'name')
    expect(product.save).to(eq(false))
  end

  describe('.not_purchased') do
    it('returns a list of products not purchased yet') do
      product = Product.create(:name => 'name', :description => 'description', :purchased => false, :price => 5)
      product2 = Product.create(:name => 'name', :description => 'description', :purchased => false, :price => 5)
      product3 = Product.create(:name => 'name', :description => 'description', :purchased => true, :price => 5)
      expect(Product.not_purchased()).to(eq([product, product2]))
    end
  end

  it('converts the name to uppercase') do
    product = Product.create(:name => 'this is the name', :description => 'description', :purchased => false, :price => 5)
    expect(product.name()).to(eq('THIS IS THE NAME'))
  end

  it("tests for uniqueness") do
    product = Product.create(:name => 'hotdog', :description => 'description', :purchased => false)
    product2 = Product.create(:name => 'hotdog', :description => 'description', :purchased => false)
    expect(product2.save).to(eq(false))
  end

  it('makes sure the price only has two decimals') do
    product = Product.create(:name => 'hardar', :description => 'a hardar', :purchased => false, :price => 5.333)
    expect(product.save()).to(eq(false))
  end


end
