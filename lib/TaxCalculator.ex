defmodule TaxCalculator do
  @moduledoc """
  Handles tax relates computations.
  """
  @basicTaxRate Application.get_env(:sales_tax, :basicTaxRate)
  @importedTaxRate Application.get_env(:sales_tax, :importedTaxRate)

  @doc """
  Calculates the total tax rate for the receipt item.
  """
  def getTaxRate(imported, exempted) do
    case {exempted, imported} do
      {true, true} -> @importedTaxRate
      {false, true} -> @importedTaxRate + @basicTaxRate
      {false, false} -> @basicTaxRate
      _ -> 0
    end
  end

  @doc """
  Calculates the total tax amount per receipt item.
  """
  def computeItemTax(%OrderItem{} = orderItem) do
    tax_rate = getTaxRate(orderItem.imported, orderItem.exempted)
    #TODO: rounding
    orderItem.price * orderItem.quantity * tax_rate / 100

  end
end
