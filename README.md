# SALES TAX PROBLEM REPORT


## Introduction

>This is my solution for sales tax problem
>After two days learning Elixir, i found this language is relly intersting.

I think this is a dumie design for the  problem. I cant leverage OO to solve this task and also, it does not have
good abstraction.In Java, i would design it better.  

## Compile - Build - Test - Run



Install all required dependencies :

  	mix deps.get

To compile the code :

	mix compile

To run ExUnit test cases :

	mix test

To build project :

	mix escript.build

To run the executable provide the input as a file. 
A sample input files are already included under priv directory and can be executed  as given below

	./sales_tax --path=priv/input3.txt

### Config
The exempted items and the tax slabs are kept in *config/config.exs*.

	config :salestax,
	exempted: ["pill", "chocolate", "book"],
	basic_tax_rate: 10,
	imported_tax_rate: 5
Any changes in slabs or exemption keywords can be made here.