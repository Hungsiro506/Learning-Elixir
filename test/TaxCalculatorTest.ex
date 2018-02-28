defmodule TaxCalculatorTest do
  use ExUnit.Case
  doctest TaxCalculator

  test "get tax_rate for tax exempted item" do
    # imported = false , exempted = true
    assert TaxCalculator.getTaxRate(false, true) == 0
  end

  test "get tax_rate for tax exempted item and imported" do
    # imported = true , exempted = true
    assert TaxCalculator.getTaxRate(true, true) == 5
  end

  test "get tax_rate for taxed item and imported" do
    # imported = true , exempted = false
    assert TaxCalculator.getTaxRate(true, false) == 15
  end

  test "get tax_rate for non imported taxed item" do
    # imported = false , exempted = true
    assert TaxCalculator.getTaxRate(false, false) == 10
  end

  test "get computed item tax for tax exempted item" do
    assert TaxCalculator.computeItemTax(%ReceiptItem{
             exempted: true,
             imported: false,
             price:  1249,
             product: "book",
             quantity: 1
           }) == 0
  end

  test "get computed item tax for tax exempted item and imported" do
    assert TaxCalculator.computeItemTax(%ReceiptItem{
             exempted: true,
             imported: true,
             price: 1249,
             product: "imported book",
             quantity: 1
           }) == 65
  end

  test "get computed item tax for taxed item and imported" do
    assert TaxCalculator.computeItemTax(%ReceiptItem{
             exempted: false,
             imported: true,
             price: 2799,
             product: "imported bottle of perfume",
             quantity: 1
           }) ==  420
  end

  test "get computed item tax for non imported taxed item" do
    assert TaxCalculator.computeItemTax(%ReceiptItem{
             exempted: false,
             imported: false,
             price:  1899,
             product: "imported bottle of perfume",
             quantity: 1
           }) ==  190
  end
end
