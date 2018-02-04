defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Hello world.
  ## Examples
      iex> Calc.hello
      :world
  """

  def main() do
    case IO.gets(">") do
      :eof ->
        IO.puts "All done"
      {:error, reason} ->
        IO.puts "Error: #{reason}"
      line ->
        eval(line)
        main()
    end
  end

  def eval(line) do
    parsed = String.trim(line)  
    input = String.split(String.trim(String.replace(String.replace(parsed, "(", "( "), ")", " )")), " ")
    #compute(input, length(input), [])

    len = length(input)
    infix_to_postfix(input, length(input), [], [])
  end

  def infix_to_postfix(input, n, stack, result) when n == 0 do
    stack = Enum.reverse(stack)
    result = result ++ stack
    result
    IO.inspect("Final result")
    IO.inspect(result)
  end

  def infix_to_postfix(input, n, stack, result) when (hd input) >="0" and (hd input) <="9" do
    c = hd input
    result = result ++ [c]
    #IO.inspect(c)
    #IO.inspect(stack)
    #IO.inspect(result)
    input = tl input
    infix_to_postfix(input, n-1, stack, result)
  end

  def infix_to_postfix(input, n, stack, result) when (hd input) =="(" do
    c = hd input
    stack = stack ++ [c]
    #IO.inspect(c)
    #IO.inspect(stack)
    #IO.inspect(result)
    input = tl input
    infix_to_postfix(input, n-1, stack, result)
  end

  def infix_to_postfix(input, n, stack, result) do
    c = hd input

    tuple = operator_fun(input, stack, result) 
    stack = elem(tuple, 0)
    result = elem(tuple, 1)

    #IO.inspect(c)
    #IO.inspect(stack)
    #IO.inspect(result)
    input = tl input
    infix_to_postfix(input, n-1, stack, result)
  end

  def operator_fun(input, stack, result) when length(stack) == 0 do
    c = hd input
    stack = stack ++ [c]
    {stack, result}
  end 

  def operator_fun(input, stack, result) do
    IO.inspect("Check 1")
    recursive_fun(input, stack, result, get_precedence(hd input), get_precedence(hd stack))
  end

  def recursive_fun(input, stack, result, p1, p2) when length(stack) != 0 and p1 <= p2 do
    IO.inspect("stack") 
    IO.inspect(stack) 
    op = elem(List.pop_at(stack, length(stack)-1), 0)   
    IO.inspect("Pop")
    IO.inspect(op)
    IO.inspect(stack) 
    result = result ++ [op]
    IO.inspect("Check 2")
    recursive_fun(input, stack, result, get_precedence(hd input), get_precedence(hd stack))
  end

  def recursive_fun(input, stack, result, p1, p2) do
    stack = stack ++ [hd input]
    IO.inspect("Check 3")
    {stack, result}
  end

  def get_precedence(operator) when operator == "+" or operator == "-" do
    1
  end

  def get_precedence(operator) when operator == "*" or operator == "/" do
    2 
  end

  def get_precedence(operator) when operator == "(" or operator == ")" do
    3 
  end

  def get_precedence(_operator) do
    -1
  end

  def get_answer(op1, op2, operator) when operator == "+" do
    op1 + op2
  end

  def get_answer(op1, op2, operator) when operator == "-" do
    op1 - op2
  end

  def get_answer(op1, op2, operator) when operator == "*" do
    op1 * op2
  end

  def get_answer(op1, op2, _operator) do
    op1 / op2
  end
 
end
Calc.main()
