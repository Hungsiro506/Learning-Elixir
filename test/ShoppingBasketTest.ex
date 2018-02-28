defmodule ShoppingBasketTest do 
  use ExUnit.Case
  doctest ShoppingBasket

  test "Add new item order to empty shopping basket should create basket item, generate total and sales taxe" do 
    assert ShoppingBasket.addItem(ShoppingBasket.new(), %ItemOrder{
                  exempted: true,
                  imported: false,
                  price: 1249,
                  product: "book",
                  quantity: 1 
      }) 
    == %ShoppingBasket{items: [Item{
                  itemTax: 0,
                  price: 1249,
                  product: "book",
                  quantity: 1
                  }],
                  total: 0,
                  salesTaxes: 0
              }
   end

   test "Add new item to shopping basket with 1 item will create basket item, generate total and sales tax" do 
      assert ShoppingBasket.addItem(%ShoppingBasket{
        item: [%Item{
          itemTax: 0,
          price: 1249,
          product: "book",
          quantity: 1
          }
        ],
      total: 1249,
      salseTaxes: 0     
        },
        ItemOrder{
             exempted: true,
                 imported: true,
                 price: 1499,
                 product: "music cd",
                 quantity: 1
        }
      }) == %ShoppingBasket{items: [
          Item{
              itemTax: 0,
            price: 1249,
            product: "book",
            quantity: 1
          },Item{
            itemTax: 75,
            price: 1574,
            product: "music cd",
            quantity: 1
          }],
        total: 2823,
        salesTaxes: 75
      }
   end    