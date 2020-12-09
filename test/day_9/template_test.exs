defmodule TemplateTest do
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

  describe "part 1 - part_1" do
    test "works for the sample data" do
      assert Template.part_1(@sample_input) == 127
    end

    @tag :skip
    test "works for the actual data" do
      assert Template.part_1() == "TODO"
    end
  end
end
