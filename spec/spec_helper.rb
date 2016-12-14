ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')


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
