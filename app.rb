require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('pry')
require('./lib/product')
require('./lib/purchase')
require('./lib/cart')
also_reload('lib/**/*.rb')

get('/') do
  @products = Product.all()
  erb(:index)
end

post('/products/new') do
  name = params.fetch('name')
  description = params.fetch('description')
  price = params.fetch('price')
  @product = Product.new({:name => name, :description => description, :price => price, :purchased => false})
  if @product.save()
    @products = Product.all()
    erb(:index)
  else
    erb(:errors)
  end
end

get("/products/:id") do
  @product = Product.find(params["id"].to_i)
  erb(:product)
end

patch("/products/:id/edit") do
  @product = Product.find(params["id"].to_i)
  name = params["name"]
  description = params["description"]
  price = params["price"]
  if name == ''
    name = @product.name
  end
  if description == ''
    description = @product.description
  end
  if price == ""
    price = @product.price
  end
  @product.update(:name => name, :description => description, :price => price)
  erb(:product)
end

delete("/") do
  @product = Product.find(params["product_id"].to_i)
  @product.delete
  @products = Product.all
  erb(:index)
end

get('/store') do
  @products = Product.all()
  erb(:store)
end

get('/store/:id') do
  @product = Product.find(params['id'].to_i)
  erb(:store_product)
end

# post('/store/:id') do
#   added_to_cart = Product.find(params['product_id'].to_i)
#   Cart.products.new(added_to_cart)
#   erb(:store)
# end
