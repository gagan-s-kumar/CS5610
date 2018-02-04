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
    compute(input, length(input), [], [])
  end

  # acc1 for integer, acc2 for operands

  def compute(input, len, acc1, acc2) do
    push_to_stack((tl input), len-1, acc1, acc2, (hd input))
  end

  # Base case
  def push_to_stack(input, len, acc1, acc2, ch) when len == 0 do
    {myInt, _} = Integer.parse(ch) 
    IO.inspect({acc1++[myInt], acc2})
  end

  def push_to_stack(input, len, acc1, acc2, ch) when ch == "+" do
    push_to_stack((tl input), len-1 , acc1, acc2++[ch], (hd input))
  end

  def push_to_stack(input, len, acc1, acc2, ch) when ch == "-" do
    push_to_stack((tl input), len-1 , acc1, acc2++[ch], (hd input))
  end

  def push_to_stack(input, len, acc1, acc2, ch) when ch == "*" do
    push_to_stack((tl input), len-1 , acc1, acc2++[ch], (hd input))
  end

  def push_to_stack(input, len, acc1, acc2, ch) when ch == "/" do
    push_to_stack((tl input), len-1 , acc1, acc2++[ch], (hd input))
  end

  # Mutual recurrsion
  def push_to_stack(input, len, acc1, acc2, ch) do
    {myInt, _} = Integer.parse(ch) 
    push_to_stack((tl input), len-1, acc1++[myInt], acc2, (hd input))
  end


end
Calc.main()
