defmodule ReceiptParser do
  @moduledoc """
  Parses the input file and transforms the items to receipt items.
  """

  @exemptions Application.get_env(:salestax, :exempted)
  @imported_keyword "imported"

  @doc """
  Reads the file and returns list of receipt items.
  """
  def init(path) do
    # drop header
    path
    |> FileReader.readFile()
    |> Stream.drop(1)
    |> getOrderItems()
  end

  def getOrderItems(input) do
    Enum.map(input, fn item ->
      item
      |> parseOrderItem()
      |> updateOrderItem()
    end)
  end

  def parseOrderItem(line_item) do
    [quantity, product, price] =
      line_item
      |> String.split(",")
      |> Enum.map(&String.trim(&1))

    OrderItem.new(validateQuantity(quantity), validateProduct(product), validatePrice(price))
  end

  def updateOrderItem(orderItem) do
    # HACK
    # Note: In real time scenario these two fields are the details obtained from
    # the product catalogue API or DB, for simplicity lets determine the category
    # and imported fields based on the item name in the receipt line item
    %OrderItem{
      orderItem
      | imported: imported?(orderItem.product),
        exempted: exempted?(orderItem.product)
    }
  end

  defp imported?(itemName) do
    itemName
    |> String.downcase()
    |> String.contains?(@imported_keyword)
  end

  defp exempted?(itemName) do
    itemName
    |> String.downcase()
    |> String.contains?(@exemptions)
  end

  def validateQuantity(qty) do
    case String.to_integer(qty) do
      quantity when quantity > 0 -> quantity
      {:error, reason} -> raise ArgumentError, message: "#{reason} -> not a supported type"
      _ -> raise ArgumentError, message: "quantity #{qty}  must be greater than zero"
    end
  end

  def validatePrice(price) do
    case String.to_float(price) do
      price when price >= 0 -> price
      {:error, reason} -> raise ArgumentError, message: "#{reason} -> not a supported type"
      _ -> raise ArgumentError, message: "price #{price}  must be >= 0"
    end
  end

  def validateProduct(product) do
    if String.trim(product) == "" do
      raise ArgumentError, message: "Product value is empty, please check"
    else
      product
    end
  end
end
