defmodule SumTwo2020 do
  def target, do: 2020

  def solution do
    sorted_list()
    |> pare_down_list(target())
    |> multiply()
  end

  def sorted_list do
    "lib/day_1/data.txt"
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.sort()
  end

  def pare_down_list(list, _target) when length(list) < 2, do: []

  def pare_down_list([first | tail] = list, target) do
    last = List.last(tail)

    cond do
      first + last == target ->
        list

      first + last > target ->
        length = Enum.count(list) - 1
        {_, list_wo_last} = List.pop_at(list, length)
        pare_down_list(list_wo_last, target)

      true ->
        pare_down_list(tail, target)
    end
  end

  def multiply([first | _rest]), do: (target() - first) * first
end
