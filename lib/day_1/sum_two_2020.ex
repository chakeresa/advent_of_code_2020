defmodule SumTwo2020 do
  @moduledoc """
  After saving Christmas five years in a row, you've decided to take a vacation
  at a nice resort on a tropical island. Surely, Christmas will go on without
  you.

  The tropical island has its own currency and is entirely cash-only. The gold
  coins used there have a little picture of a starfish; the locals just call
  them stars. None of the currency exchanges seem to have heard of them, but
  somehow, you'll need to find fifty of these coins by the time you arrive so
  you can pay the deposit on your room.

  To save your vacation, you need to get all fifty stars by December 25th.

  Collect stars by solving puzzles. Two puzzles will be made available on each
  day in the Advent calendar; the second puzzle is unlocked when you complete
  the first. Each puzzle grants one star. Good luck!

  Before you leave, the Elves in accounting just need you to fix your expense
  report (your puzzle input -- see `data.txt`); apparently, something isn't
  quite adding up.

  Specifically, they need you to find the two entries that sum to 2020 and then
  multiply those two numbers together.

  For example, suppose your expense report contained the following:

  1721
  979
  366
  299
  675
  1456
  In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying
  them together produces 1721 * 299 = 514579, so the correct answer is 514579.

  Of course, your expense report is much larger. Find the two entries that sum
  to 2020; what do you get if you multiply them together?

  Your puzzle answer was 605364.
  """

  @list_of_lines_from_txt FileImport.list_of_lines("lib/day_1/data.txt")

  def target, do: 2020

  def solution(list_of_lines \\ @list_of_lines_from_txt) do
    sorted_list(list_of_lines)
    |> pare_down_list(target())
    |> multiply()
  end

  def sorted_list(list_of_lines) do
    list_of_lines
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
