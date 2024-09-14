defmodule Chapter3_4 do
  @moduledoc """
  Chapter 3.4 practice functions.
  """

  @doc """
  Calculate the length of a list.

  Returns integer.

  ## Examples

    iex> Chapter3_4.list_len([3, 4, 5])
    3

    iex> Chapter3_4.list_len([])
    0

  """
  def list_len(the_list) do
    _list_len(0, the_list)
  end

  def _list_len(count, []), do: count

  def _list_len(count, [_ | tail]) do
    _list_len(count + 1, tail)
  end

  @doc """
  Return list of all integers in the given range, inclusive of from and to.

  ## Examples

    iex> Chapter3_4.range(3, 5)
    [3, 4, 5]
  """
  def range(from, to) when is_number(from) and is_number(to) and to == from do
    [from]
  end

  def range(from, to) when is_number(from) and is_number(to) and to < from do
    Enum.reverse(range(to, from))
  end

  def range(from, to) when is_number(from) and is_number(to) do
    _range([], from, to)
  end

  def _range(collector, from, to) when from == to do
    [from | collector]
  end

  def _range(collector, from, to) do
    _range([from | collector], from + 1, to)
  end

  @doc """
  Return list of all positive integers in the list.

  ## Examples

    iex> Chapter3_4.positive([3, -5, 12])
    [3, 12]
  """
  def positive(the_list) do
    Enum.reverse(_positive([], the_list))
  end

  def _positive(collector, []), do: collector

  def _positive(collector, [head | tail]) do
    if head > 0 do
      _positive([head | collector], tail)
    else
      _positive(collector, tail)
    end
  end
end

IO.puts("Three")
IO.inspect(Chapter3_4.list_len([3, 4, 5]))

IO.puts("Zero")
IO.inspect(Chapter3_4.list_len([]))

IO.puts("Range 3 to 5")
IO.inspect(Chapter3_4.range(3, 5))

IO.puts("Range 5 to 3")
IO.inspect(Chapter3_4.range(5, 3))

IO.puts("Range 22 to 22")
IO.inspect(Chapter3_4.range(22, 22))

IO.puts("Positive: 3, 12")
IO.inspect(Chapter3_4.positive([3, -5, 12]))
