defmodule Recursion do
  @list_of_lines_from_txt FileImport.list_of_lines("lib/other_years/2017/day_7/data.txt")

  def part_1(list_of_lines \\ @list_of_lines_from_txt) do
    full_input = Enum.join(list_of_lines, "\n")

    list_of_lines
    |> Enum.find(fn line ->
      name = first_word(line)
      !String.match?(full_input, ~r/.*#{name}.*#{name}.*/s)
    end)
    |> first_word()
  end

  def first_word(line) do
    line
    |> String.split()
    |> List.first()
  end
end
