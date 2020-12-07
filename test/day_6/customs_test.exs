defmodule CustomsTest do
  use ExUnit.Case

  describe "part 1 - sum_of_group_counts" do
    test "works for the sample data" do
      input = [
        "abc",
        "a\nb\nc",
        "ab\nac",
        "a\na\na\na",
        "b"
      ]

      assert Customs.sum_of_group_counts(input) == 11
    end

    test "works for the actual data" do
      assert Customs.sum_of_group_counts() == 6683
    end
  end
end
