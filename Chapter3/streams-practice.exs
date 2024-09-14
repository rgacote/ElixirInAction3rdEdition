defmodule LinesLengths do
  @moduledoc """
  Line lengths of a file using streams.
  """

  def lines_lengths!(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Enum.map(&String.length(&1))
  end

  def longest_line_length!(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Stream.map(&String.length(&1))
    |> Enum.max()
  end

  def _acc_longest_line(line, %{line_length: acc_length, text: acc_text}) do
    line_length = String.length(line)

    if line_length > acc_length do
      %{line_length: line_length, text: line}
    else
      %{line_length: acc_length, text: acc_text}
    end
  end

  def longest_line!(path) do
    result =
      path
      |> File.stream!()
      |> Stream.map(&String.trim_trailing(&1, "\n"))
      |> Enum.reduce(%{line_length: 0, text: ""}, fn item, acc ->
        _acc_longest_line(item, acc)
      end)

    %{line_length: _line_length, text: text} = result
    text
  end

  def words_per_line!(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Enum.map(&length(String.split(&1)))
  end
end

path = "./streams-practice.exs"
IO.inspect(LinesLengths.lines_lengths!(path), label: "Line Lengths")
IO.inspect(LinesLengths.longest_line_length!(path), label: "Longest line length")
IO.inspect(LinesLengths.longest_line!(path), label: "Longest line")
IO.inspect(LinesLengths.words_per_line!(path), label: "Words per line")
