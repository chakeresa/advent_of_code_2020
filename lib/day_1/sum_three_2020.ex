defmodule SumThree2020 do
  @moduledoc """
  The Elves in accounting are thankful for your help; one of them even offers
  you a starfish coin they had left over from a past vacation. They offer you a
  second one if you can find three numbers in your expense report that meet the
  same criteria.

  Using the example in `SumTwo2020` again, the three entries that sum to 2020
  are 979, 366, and 675. Multiplying them together produces the answer,
  241861950.

  In your expense report, what is the product of the three entries that sum to
  2020?

  Your puzzle answer was 128397680.
  """
  @list_of_lines_from_txt FileImport.list_of_lines("lib/day_1/data.txt")

  def solution(list_of_lines \\ @list_of_lines_from_txt) do
    sorted = SumTwo2020.sorted_list(list_of_lines)

    Enum.reduce_while(sorted, sorted, fn _elem, [first | tail] ->
      tail
      |> SumTwo2020.pare_down_list(SumTwo2020.target() - first)
      |> case do
        [] -> {:cont, tail}
        [_] -> {:cont, tail}
        [second | _rest] -> {:halt, multiply(first, second)}
      end
    end)
  end

  def multiply(first, second) do
    third = SumTwo2020.target() - first - second
    first * second * third
  end
end
