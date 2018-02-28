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

   @doc """
  Transforms shopping basket item to string for display and writing invoice to file.
  """
  def generate_invoice(%ShoppingBasket{items: items, sales_tax: sales_tax, total: total}) do
    invoice =
      Enum.reduce(items, "", fn %BasketItem{quantity: quantity, product: product, price: price},
                                acc ->
        acc <> join(Integer.to_string(quantity), product, Money.to_string(price))
      end)

    invoice <>
      "\nSales Taxes: " <>
      Money.to_string(sales_tax) <> "\n" <> "Total: " <> Money.to_string(total) <> "\n"
  end

  defp join(quantity, product, price) do
    quantity <> ", " <> product <> ", " <> price <> "\n"
  end

  
end
