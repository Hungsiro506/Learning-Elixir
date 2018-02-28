defmodule AP do
  @moduledoc """
  Documentation for AP.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AP.hello
      :world

  """

  def main(args) do
    args |> parseArgs |> process
  end

  def process([]) do
    IO.puts("No arguments given")
  end

  def process(options) do
    # |> ShoppingBasket.print_invoice
    ReceiptParser.init(options)
    |> List.foldl(ShoppingBasket.new(), fn orderItem, shoppingBasket ->
      ShoppingBasket.addItem(shoppingBasket, orderItem)
    end)
    |> ShoppingBasket.generateInvoice()
    |> FileReader.writeToFile(options)
  end

  defp parseArgs(args) do
    {options, _, _} = OptionParser.parse(args, switches: [path: :string])
    Path.absname(options[:path])
  end


end
