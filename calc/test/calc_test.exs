defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "greets the world" do
    assert Calc.hello() == :world
  end

  test "eval test" do
    assert Calc.eval("3 + 4") == 7
  end

end
