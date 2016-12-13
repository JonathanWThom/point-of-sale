require('spec_helper')

describe(Product) do
  it {should belong_to(:purchase)}

  it("tests presence of name attribute") do
    product = Product.create(:name => "")
    expect(product.save).to(eq(false))
  end
end
