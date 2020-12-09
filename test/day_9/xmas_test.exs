defmodule XMASTest do
  use ExUnit.Case

  @sample_input [
    "35",
    "20",
    "15",
    "25",
    "47",
    "40",
    "62",
    "55",
    "65",
    "95",
    "102",
    "117",
    "150",
    "182",
    "127",
    "219",
    "299",
    "277",
    "309",
    "576"
  ]

  describe "part 1 - weakness_value" do
    test "works for the sample data" do
      assert XMAS.weakness_value(@sample_input, 5) == 127
    end

    test "works for the actual data" do
      assert XMAS.weakness_value() == 29_221_323
    end
  end

  describe "part 2 - part_2" do
    test "works for the sample data" do
      assert XMAS.part_2(@sample_input, 5) == 62
    end

    @tag :skip
    test "works for the actual data" do
      assert XMAS.part_2() == "TODO"
    end
  end
end
