require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('pry')
require('./lib/product')
require('./lib/purchase')
also_reload('lib/**/*.rb')

get('/') do
  @products = Product.all()
  erb(:index)
end

post('/products/new') do
  name = params.fetch('name')
  description = params.fetch('description')
  price = params.fetch('price')
  @product = Product.create({:name => name, :description => description, :price => price, :purchased => false})
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
