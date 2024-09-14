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
end

IO.puts("Three")
Chapter3.list_len([3, 4, 5])

IO.puts("Zero")
Chapter3.list_len([])
