defmodule SumThree2020Test do
  use ExUnit.Case

  test "works for the example data" do
    assert SumThree2020.solution([
             "1721",
             "979",
             "366",
             "299",
             "675",
             "1456"
           ]) == 241_861_950
  end

  test "works for the real data" do
    assert SumThree2020.solution() == 128_397_680
  end
end
