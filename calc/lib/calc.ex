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
#    input
#    |> Enum.map(&infix_to_postfix/1)
    compute(input, length(input), [], [], (hd input))
  end

  def compute(input, n, stack, result, c) when n > 0 do
    infix_to_postfix((tl input), n-1, stack, result, (hd input))
  end


  def infix_to_postfix(input, n, stack, result, c) when n == 0 do
    result
  end

  def infix_to_postfix(input, n, stack, result, c) when c >="0" and c <="9" do
    IO.inspect(c)
    result = result ++ [c]
    IO.inspect(result)
    infix_to_postfix((tl input), n-1, stack, result, (hd input))
  end

  def infix_to_postfix(input, n, stack, result, c) when c == "(" do
    stack = stack ++ [c]
    infix_to_postfix((tl input), n-1, stack, result, (hd input))
  end

  def infix_to_postfix(input, n, stack, result, c) do
    default_function(stack, result, get_precedence(c), get_precedence(hd stack), c)
  end

  def default_function(stack, result, p1, p2, c) when length(stack) > 0 and p1 <= p2 do
    result = result ++ [hd stack]
    stack = stack ++ [c]
    default_function(stack, result, get_precedence(c), get_precedence(hd stack), c) 
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
