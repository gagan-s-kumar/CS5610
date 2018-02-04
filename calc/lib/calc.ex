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
    input = String.split(String.replace(parsed," ", ""), "", trim: true) 
    input 
    |> Enum.map(&push_to_stack/1)
  end

  def push_to_stack(str) do
    push_to_stack(str, [], [])
  end

  #acc1 for integer, acc2 for operands

  def push_to_stack(str, acc1, acc2) when str == "+" do
    acc2 = acc2 ++ [str]
    IO.inspect(str)
    IO.inspect(acc1)
    IO.inspect(acc2)
  end
  
  def push_to_stack(str, acc1, acc2) do
    acc1 = acc1 ++ [str]
    IO.inspect(str)
    IO.inspect(acc1)
    IO.inspect(acc2)
  end

end
Calc.main()
