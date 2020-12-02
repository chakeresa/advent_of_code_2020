defmodule SumThree2020 do
  def solution do
    sorted = SumTwo2020.sorted_list()

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
