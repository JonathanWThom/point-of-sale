require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  if Purchase.current_purchase == []
    @purchase = Purchase.create(:date_of_purchase => Date.today, :purchased => false)
  else
    @purchase = Purchase.current_purchase[0]
  end
  @products = Product.all()
  erb(:index)
end

post('/products/new') do
  @purchase = Purchase.current_purchase[0]
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
  @purchase = Purchase.current_purchase[0]
  @product = Product.find(params["id"].to_i)
  erb(:product)
end

patch("/products/:id/edit") do
  @purchase = Purchase.current_purchase[0]
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
  @purchase = Purchase.current_purchase[0]
  @product = Product.find(params["product_id"].to_i)
  @product.delete
  @products = Product.all
  erb(:index)
end

get('/store') do
  @purchase = Purchase.current_purchase[0]
  @products = Product.all()
  erb(:store)
end

get('/store/:id') do
  @purchase = Purchase.current_purchase[0]
  @product = Product.find(params['id'].to_i)
  erb(:store_product)
end

patch('/store') do
  @purchase = Purchase.current_purchase[0]
  product = Product.find(params['product_id'].to_i)
  product.update({:purchase_id => @purchase.id, :purchased => true})
  @products = Product.all
  erb(:store)
end


get("/cart") do
  @purchase = Purchase.current_purchase[0]
  erb(:cart)
end

patch('/confirmation') do
  @purchase = Purchase.current_purchase[0]
  purchase_id = @purchase.id
  @purchase.update({:purchased => true})
  @purchase = Purchase.create(:date_of_purchase => Date.today, :purchased => false)
  @old_purchase = Purchase.find(purchase_id)
  erb(:confirmation)
end

get('/sales') do
  @purchase = Purchase.current_purchase[0]
  erb(:sales)
end

get('/sales/report') do
  @purchase = Purchase.current_purchase[0]
  start_date = params['start_date']
  # date1 = Date.new(start_date.year, start_date.month, start_date.day)
  end_date = params['end_date']
  # date2 = Date.new(end_date.year, end_date.month, end_date.day)
  @total = Purchase.purchases_total(start_date, end_date)
  erb(:sales_report)
end
