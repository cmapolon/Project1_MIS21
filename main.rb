require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

# ROUTES FOR ADMIN SECTION

get '/' do
   random = Item.all
   @products = random.sample(10)
   erb :home
end

get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/about' do
  erb :about
end

get '/products' do
   @products = Item.all
   erb :product
end

get '/buy/:id' do
  @product = Item.find(params[:id])
  erb :buy
end

post '/next/:id' do
  error = ""
  @error = error

  @product = Item.find(params[:id])

  quantity_purchased = params[:quantity_purchased]
  @quantity_purchased = quantity_purchased
  @bill = @quantity_purchased.to_i * @product.price
 
  if quantity_purchased.to_i > @product.quantity.to_i
    error = "Not enough in inventory."
    @error = error

  else
    @error = error
    moneycalc = MoneyCalculator.new params[:one].to_i, params[:five].to_i, params[:ten].to_i, params[:twenty].to_i, params[:fifty].to_i, params[:hundred].to_i, params[:five_hundred].to_i, params[:thousand].to_i
    @given_change = moneycalc.total
    @hash = moneycalc.change(@bill)

    if @bill.to_i > @given_change.to_i
  	error= "Input not enough."
  	@error = error
  
    else
  	@change = @given_change - @bill
	remaining = @product.quantity.to_i - @quantity_purchased.to_i
	@product.sold = @product.sold + @quantity_purchased.to_i
	@product.update_attributes!(
        quantity: remaining)
  	erb :bill
  end

  end

  end

post '/bill/:id' do
  @product = Item.find(params[:id])
end


get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
  @item = Item.new
  @item.name = params[:name]
  @item.price = params[:price]
  @item.quantity = params[:quantity]
  @item.sold = 0
  @item.save
  redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION
