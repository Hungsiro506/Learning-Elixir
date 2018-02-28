defmodule APTest do
  use ExUnit.Case
  doctest AP

  test "greets the world" do
    assert AP.hello() == :world
  end
end
