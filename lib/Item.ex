defmodule BasketItem do
  @moduledoc """
  Struct to hold receipt item with updated price and item tax .
  """
  import TaxCalculator, only: [compute_item_tax: 1]

  defstruct quantity: 0, product: nil, price: nil, item_tax: nil

  @type t :: %__MODULE__{
          quantity: integer,
          product: String.t(),
          price: integer,
          item_tax: integer

  @doc """
  Transforms receipt item to basket item with updated price and item tax for each
  receipt item.
  """
  def new(%OrderItem{} = orderItem) do
    item_tax = compute_item_tax(orderItem)

    %__MODULE__{
      quantity: orderItem.quantity,
      product: orderItem.product,
      price:
        Money.multiply(orderItem.price, orderItem.quantity)
        |> Money.add(item_tax),
      item_tax: item_tax
    }
  end
end
