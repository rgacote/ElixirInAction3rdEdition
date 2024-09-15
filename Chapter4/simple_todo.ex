defmodule Fraction do
  defstruct a: nil, b: nil

  def new(a, b) do
    %Fraction{a: a, b: b}
  end

  def value(%Fraction{a: a, b: b}) do
    a / b
  end

  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    new(a1 * b2 + a2 * b1, b2 * b1)
  end
end

defmodule MultiDict do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], &[value | &1])
  end

  def get(dict, key) do
    Map.get(dict, key, [])
  end

  def get_in_insertion_order(dict, key) do
    Enum.reverse(get(dict, key))
  end
end

defmodule TodoList do
  def new(), do: MultiDict.new()

  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  @doc """
  Get entries for date in order in which they were inserted.
  """
  def entries(todo_list, date) do
    MultiDict.get_in_insertion_order(todo_list, date)
  end
end
