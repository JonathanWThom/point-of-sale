ENV['RACK_ENV'] = 'test'

require('sinatra/activerecord')
require('sinatra')
require('rspec')
require('pry')
require('shoulda-matchers')
require('capybara')
require('product')
require('purchase')

RSpec.configure do |config|
  config.after(:each) do
    Product.all().each do |product|
      product.destroy()
    end
    Purchase.all().each do |purchase|
      purchase.destroy()
    end
  end
end
