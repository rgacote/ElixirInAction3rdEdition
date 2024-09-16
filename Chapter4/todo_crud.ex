defimpl String.Chars, for: TodoList do
  def to_string(_) do
    "#TodoList"
  end
end

defmodule TodoList do
  defstruct next_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.next_id)
    new_entries = Map.put(todo_list.entries, todo_list.next_id, entry)
    %TodoList{todo_list | entries: new_entries, next_id: todo_list.next_id + 1}
  end

  def update_entry(todo_list, entry_id, updater_func) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_func.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  # Throws error on missing key.
  def delete_entry_rgac(todo_list, entry_id) do
    Map.delete(todo_list.entries, entry_id)
  end

  def delete_entry(todo_list, entry_id) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(fn entry -> entry.date == date end)
  end
end

defmodule TodoList.CsvImporter do
  defp to_date([head | tail]) do
    IO.puts(Date.to_string(Date.from_iso8601!(head)))
    [Date.from_iso8601!(head) | tail]
  end

  defp to_map([date | title]) do
    %{date: date, title: title}
  end

  # Tried to do too much in the pipeline.
  # Book sample shows pipeline broken into read_lines and create_entries before piping into TodoList.new()
  def load_csv(path \\ "./todos.csv") do
    todo_list =
      path
      |> File.stream!()
      |> IO.inspect(label: "File Stream")
      |> Stream.map(&String.trim_trailing(&1))
      |> IO.inspect(label: "Trimmed")
      |> Stream.map(&String.split(&1, ","))
      |> Stream.map(&to_date(&1))
      |> IO.inspect(label: "To date")
      |> Stream.map(&to_map(&1))
      |> IO.inspect(label: "Mapped")
      |> TodoList.new()
      |> IO.inspect(label: "Todo List")
      |> IO.puts()
  end
end

TodoList.CsvImporter.load_csv()
