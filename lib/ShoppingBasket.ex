defmodule ShoppingBasket do
  @moduledoc """
  Documentation for SalesTax.
  """
  defstruct total: 0, salesTax: 0, items: []

  def new, do: %__MODULE__{}

  @doc """
  Transforms order item to basket item and adds to shopping basket, computing
  total and sales tax upon add of each item.
  """

  def addItem(%__MODULE__{} = shoppingBasket, %OrderItem{} = orderItem) do
    basketItem = BasketItem.new(orderItem)

    %{
      shoppingBasket
      | total: shoppingBasket.total +  Item.price,
        salesTax: shoppingBasket.salesTax + basketItem.itemTax,
        items: shoppingBasket.items ++ [basketItem]
    }
  end

   @doc """
  Transforms shopping basket item to string for display and writing invoice to file.
  """
  def generateInvoice(%ShoppingBasket{items: items, salesTax: salesTax, total: total}) do
    invoice =
      Enum.reduce(items, "", fn %Item{quantity: quantity, product: product, price: price},
                                acc ->
        acc <> join(Integer.to_string(quantity), product, Integer.to_string(price))
      end)

    invoice <>
      "\nSales Taxes: " <>
      Integer.to_string(salesTax) <> "\n" <> "Total: " <> Integer.to_string(total) <> "\n"
  end

  defp join(quantity, product, price) do
    quantity <> ", " <> product <> ", " <> price <> "\n"
  end

  
end
