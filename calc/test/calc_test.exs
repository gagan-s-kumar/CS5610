defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "greets the world" do
    assert Calc.hello() == :world
  end

  test "eval test" do
    assert Calc.eval("2 + 3") == 5
    assert Calc.eval("5 * 1") == 5
    assert Calc.eval("20 / 4") == 5
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
    assert Calc.eval("1 + 3 * 3 + 1") == 11 
  end

  test "infix_to_postfix test" do
    assert Calc.infix_to_postfix(["3", "+", "4"], 3, [], []) == 7
  end

  test "compute_postfix test" do
    assert Calc.compute_postfix([3, 4, "+"], 3, []) == [7]
  end

end
