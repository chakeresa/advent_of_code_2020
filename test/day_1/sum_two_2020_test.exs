defmodule SumTwo2020Test do
  use ExUnit.Case

  test "works for the example data" do
    assert SumTwo2020.solution([
             "1721",
             "979",
             "366",
             "299",
             "675",
             "1456"
           ]) == 514_579
  end

  test "works for the real data" do
    assert SumTwo2020.solution() == 605_364
  end
end
