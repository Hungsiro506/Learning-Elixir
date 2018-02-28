defmodule APTest do
  use ExUnit.Case
  doctest AP

  test "greets the world" do
    assert AP.hello() == :world
  end

  test "Empty shoping basket should return Total 0" do
  	assert ShoppingBasket.getTotal == 0
  end

  test "Empty shopping basket should return Taxes 0" do
  	assert ShoppingBasket.getTaxes == 0
  end

  test "Add new item order to empty shopping basket should create basket item, generate total and sales taxe" do 
  	assert ShoppingBasket.addItem(ShoppingBasket.new(), %ItemOrder{}) 
  	== %ShoppingBasket{items: [Item{}],
  								total: 0,
  								salesTaxes: 0
  					  }
   end

   test "Add new item to shopping basket with 1 item will create basket item, generate total and sales tax" do 
   		assert ShoppingBasket.addItem(ShoppingBasket{
   			item: [%Item{}],
   			order: %ItemOrder{}
   		}) == %ShoppingBasket{items: [Item{}],
  								total: 0,
  								salesTaxes: 0
  							}
   end 		
end
