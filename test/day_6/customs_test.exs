defmodule CustomsTest do
  use ExUnit.Case

  @sample_input [
    "abc",
    "a\nb\nc",
    "ab\nac",
    "a\na\na\na",
    "b"
  ]

  describe "part 1 - sum_of_anyone_yes" do
    test "works for the sample data" do
      assert Customs.sum_of_anyone_yes(@sample_input) == 11
    end

    test "works for the actual data" do
      assert Customs.sum_of_anyone_yes() == 6683
    end
  end

  describe "part 2 - sum_of_everyone_yes" do
    test "works for the sample data" do
      assert Customs.sum_of_everyone_yes(@sample_input) == 6
    end

    test "works for the actual data" do
      assert Customs.sum_of_everyone_yes() == 3122
    end
  end
end
