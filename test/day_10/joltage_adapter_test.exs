defmodule JoltageAdapterTest do
  use ExUnit.Case

  @sample_input_1 [
    "16",
    "10",
    "15",
    "5",
    "1",
    "11",
    "7",
    "19",
    "6",
    "12",
    "4"
  ]

  @sample_input_2 [
    "28",
    "33",
    "18",
    "42",
    "31",
    "14",
    "46",
    "20",
    "48",
    "47",
    "24",
    "23",
    "49",
    "45",
    "19",
    "38",
    "39",
    "11",
    "1",
    "32",
    "25",
    "35",
    "8",
    "17",
    "7",
    "9",
    "4",
    "2",
    "34",
    "10",
    "3"
  ]

  describe "part 1 - part_1" do
    test "works for the sample data" do
      assert JoltageAdapter.part_1(@sample_input_1) == 7 * 5
      assert JoltageAdapter.part_1(@sample_input_2) == 22 * 10
    end

    test "works for the actual data" do
      assert JoltageAdapter.part_1() == 1904
    end
  end

  describe "part 2 - possible_arrangement_count" do
    test "works for the sample data" do
      assert JoltageAdapter.possible_arrangement_count(@sample_input_1) == 8
      assert JoltageAdapter.possible_arrangement_count(@sample_input_2) == 19208
    end

    test "works for the actual data" do
      assert JoltageAdapter.possible_arrangement_count() == 10_578_455_953_408
    end
  end
end
