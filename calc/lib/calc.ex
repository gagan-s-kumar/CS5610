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

  def get_answer(op1, op2, operator) when operator == "+" do
    op1 + op2
  end

  def get_answer(op1, op2, operator) when operator == "-" do
    op1 - op2
  end

  def get_answer(op1, op2, operator) when operator == "*" do
    op1 * op2
  end

  def get_answer(op1, op2, operator) do
    op1 / op2
  end

  def do_compute(tuple) do
    final_answer = tuple
    IO.inspect(tuple)
    val = elem(tuple, 0)
    ops = elem(tuple, 1)
    op1 = hd val
    val = tl val
    op2 = hd val
    val = tl val
    val = val ++ ["eos"]
    operator = hd ops
    ops = tl ops
    answer = get_answer(op1, op2, operator)
    IO.inspect(answer)
    newval = [answer] ++ val
    #newval = List.delete(newval, "eos")
    {newval, ops}
  end

  # Base case
  def push_to_stack(input, len, acc1, acc2, ch) when len == 0 and ch == ")" do
    IO.inspect(do_compute({acc1, acc2++[ch]}))
  end

  def push_to_stack(input, len, acc1, acc2, ch) when len == 0 do
    {myInt, _} = Integer.parse(ch) # Change this when () is added 
    IO.inspect(do_compute({acc1++[myInt], acc2}))
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

  def push_to_stack(input, len, acc1, acc2, ch) when ch == "(" do
    push_to_stack((tl input), len-1 , acc1, acc2++[ch], (hd input))
  end

  def push_to_stack(input, len, acc1, acc2, ch) when ch == ")" do
    push_to_stack((tl input), len-1 , acc1, acc2++[ch], (hd input))
  end

  # Mutual recurrsion
  def push_to_stack(input, len, acc1, acc2, ch) do
    {myInt, _} = Integer.parse(ch) 
    push_to_stack((tl input), len-1, acc1++[myInt], acc2, (hd input))
  end


end
Calc.main()
