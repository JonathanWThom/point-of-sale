require('spec_helper')

describe(Cart) do
  it {should have_many(:products)}
end
