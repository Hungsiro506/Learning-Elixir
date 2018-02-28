defmodule Item do
  @moduledoc """
  Struct to hold receipt item with updated price and item tax .
  """
  import TaxCalculator, only: [computeItemTax: 1]

  defstruct quantity: 0, product: nil, price: nil, itemTax: nil

  @type t :: %__MODULE__{
          quantity: integer,
          product: String.t(),
          price: integer,
          itemTax: integer
    }
  @doc """
  Transforms receipt item to basket item with updated price and item tax for each
  receipt item.
  """
  def new(%OrderItem{} = orderItem) do
    itemTax = computeItemTax(orderItem)

    %__MODULE__{
      quantity: orderItem.quantity,
      product: orderItem.product,
      price: orderItem.price * orderItem.quantity + itemTax,
      itemTax: itemTax
    }
  end
end
