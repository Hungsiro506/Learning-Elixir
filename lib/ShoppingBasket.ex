defmodule ShoppingBasket do
  @moduledoc """
  Documentation for SalesTax.
  """
  defstruct total: 0, sales_tax: 0, items: []

  def new, do: %__MODULE__{}

  @doc """
  Transforms order item to basket item and adds to shopping basket, computing
  total and sales tax upon add of each item.
  """
  def addItem(%__MODULE__{} = shoppingBasket, %ItemOrder{} = orderItem) do
    basketItem = BasketItem.new(orderItem)

    %{
      shoppingBasket
      | total: shoppingBasket.total +  Item.price,
        sales_tax: shoppingBasket.salesTax + basketItem.itemTax,
        items: shoppingBasket.items ++ [basketItem]
    }
  end

  
end
