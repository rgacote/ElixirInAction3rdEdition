defmodule Chapter3 do
  @moduledoc """
  Chapter 3 practice functions.
  """

  @doc """
  Calculate the length of a list.

  Returns integer.

  ## Examples

    iex> Chapter3.list_len([3, 4, 5])
    3

    iex> Chapter3.list_len([])
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

    iex> Chapter3.range(3, 5)
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
end

IO.puts("Three")
IO.inspect(Chapter3.list_len([3, 4, 5]))

IO.puts("Zero")
IO.inspect(Chapter3.list_len([]))

IO.puts("Range 3 to 5")
IO.inspect(Chapter3.range(3, 5))

IO.puts("Range 5 to 3")
IO.inspect(Chapter3.range(5, 3))

IO.puts("Range 22 to 22")
IO.inspect(Chapter3.range(22, 22))
