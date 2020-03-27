defmodule TodotinTest do
  use ExUnit.Case
  doctest Todotin

  test "greets the world" do
    assert Todotin.hello() == :world
  end
end
