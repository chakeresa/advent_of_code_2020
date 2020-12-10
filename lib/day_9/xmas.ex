defmodule XMAS do
  @list_of_lines_from_txt FileImport.list_of_lines("lib/day_9/data.txt")

  defstruct [
    :index,
    :list_of_lines,
    :preamble_length
  ]

  defmodule Part2 do
    defstruct [:start_index, :end_index, :max_index, :sum_to, :list_of_integers]
  end

  @doc """
  With your neighbor happily enjoying their video game, you turn your attention
  to an open data port on the little screen in the seat in front of you.

  Though the port is non-standard, you manage to connect it to your computer
  through the clever use of several paperclips. Upon connection, the port
  outputs a series of numbers (your puzzle input).

  The data appears to be encrypted with the eXchange-Masking Addition System
  (XMAS) which, conveniently for you, is an old cypher with an important
  weakness.

  XMAS starts by transmitting a preamble of 25 numbers. After that, each number
  you receive should be the sum of any two of the 25 immediately previous
  numbers. The two numbers will have different values, and there might be more
  than one such pair.

  For example, suppose your preamble consists of the numbers 1 through 25 in a
  random order. To be valid, the next number must be the sum of two of those
  numbers:

  - 26 would be a valid next number, as it could be 1 plus 25 (or many other
  pairs, like 2 and 24).
  - 49 would be a valid next number, as it is the sum of 24 and 25.
  - 100 would not be valid; no two of the previous 25 numbers sum to 100.
  - 50 would also not be valid; although 25 appears in the previous 25 numbers,
  the two numbers in the pair must be different.

  Suppose the 26th number is 45, and the first number (no longer an option, as
  it is more than 25 numbers ago) was 20. Now, for the next number to be valid,
  there needs to be some pair of numbers among 1-19, 21-25, or 45 that add up to
  it:

  - 26 would still be a valid next number, as 1 and 25 are still within the
  previous 25 numbers.
  - 65 would not be valid, as no two of the available numbers sum to it.
  - 64 and 66 would both be valid, as they are the result of 19+45 and 21+45
  respectively.

  Here is a larger example which only considers the previous 5 numbers (and has
  a preamble of length 5):
  ```
  35
  20
  15
  25
  47
  40
  62
  55
  65
  95
  102
  117
  150
  182
  127
  219
  299
  277
  309
  576
  ```
  In this example, after the 5-number preamble, almost every number is the sum
  of two of the previous 5 numbers; the only number that does not follow this
  rule is 127.

  The first step of attacking the weakness in the XMAS data is to find the
  first number in the list (after the preamble) which is not the sum of two of
  the 25 numbers before it. What is the first number that does not have this
  property?

  Your puzzle answer was 29221323.
  """
  def weakness_value(list_of_lines \\ @list_of_lines_from_txt, preamble_length \\ 25) do
    integer_at(
      list_of_lines,
      weakness_index(list_of_lines, preamble_length)
    )
  end

  def weakness_index(list_of_lines, preamble_length) do
    %__MODULE__{index: index} =
      %__MODULE__{
        index: preamble_length,
        list_of_lines: list_of_lines,
        preamble_length: preamble_length
      }
      |> next()

    index
  end

  def valid?(%__MODULE__{
        index: index,
        list_of_lines: list_of_lines,
        preamble_length: preamble_length
      }) do
    lines_to_draw_from = Enum.slice(list_of_lines, index - preamble_length, preamble_length)

    target = integer_at(list_of_lines, index)

    !is_nil(SumTwo2020.solution(lines_to_draw_from, target))
  end

  def next(%__MODULE__{index: index} = xmas) do
    if valid?(xmas) do
      %{xmas | index: index + 1} |> next()
    else
      xmas
    end
  end

  def integer_at(list_of_lines, index) do
    list_of_lines
    |> Enum.at(index)
    |> String.to_integer()
  end

  @doc """
  The final step in breaking the XMAS encryption relies on the invalid number
  you just found: you must find a contiguous set of at least two numbers in your
  list which sum to the invalid number from step 1.

  Again consider the above example:
  ```
  35
  20
  15
  25
  47
  40
  62
  55
  65
  95
  102
  117
  150
  182
  127
  219
  299
  277
  309
  576
  ```
  In this list, adding up all of the numbers from 15 through 40 produces the
  invalid number from step 1, 127. (Of course, the contiguous set of numbers in
  your actual list might be much longer.)

  To find the encryption weakness, add together the smallest and largest number
  in this contiguous range; in this example, these are 15 and 47, producing 62.

  What is the encryption weakness in your XMAS-encrypted list of numbers?
  """
  def part_2(list_of_lines \\ @list_of_lines_from_txt, preamble_length \\ 25) do
    weakness_idx = weakness_index(list_of_lines, preamble_length)
    goal = integer_at(list_of_lines, weakness_idx)
    list_of_integers = Enum.map(list_of_lines, &String.to_integer/1)

    %__MODULE__.Part2{start_index: soln_start_idx, end_index: soln_end_idx} =
      %__MODULE__.Part2{
        sum_to: goal,
        max_index: weakness_idx,
        start_index: 0,
        end_index: 1,
        list_of_integers: list_of_integers
      }
      |> find_range()

    summed_ints =
      list_of_integers
      |> Enum.slice(soln_start_idx..soln_end_idx)
      |> Enum.sort()

    List.first(summed_ints) + List.last(summed_ints)
  end

  def find_range(
        %__MODULE__.Part2{start_index: start_index, end_index: end_index, max_index: max_index} =
          data
      ) do
    cond do
      solution?(data) ->
        data

      end_index < max_index ->
        %{data | end_index: end_index + 1} |> find_range()

      true ->
        %{data | start_index: start_index + 1, end_index: start_index + 2} |> find_range()
    end
  end

  def solution?(%__MODULE__.Part2{
        start_index: start_index,
        end_index: end_index,
        sum_to: sum_to,
        list_of_integers: list_of_integers
      }) do
    sum_to ==
      list_of_integers
      |> Enum.slice(start_index..end_index)
      |> Enum.sum()
  end
end
