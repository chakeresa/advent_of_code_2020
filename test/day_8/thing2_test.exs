defmodule Thing2Test do
  use ExUnit.Case

  @sample_input [
    # TODO
    "abc",
    "a\nb\nc",
    "ab\nac",
    "a\na\na\na",
    "b"
  ]

  describe "part 1 - part_1" do
    @tag :skip
    test "works for the sample data" do
      assert Thing2.part_1(@sample_input) == 42
    end

    @tag :skip
    test "works for the actual data" do
      assert Thing2.part_1() == 42
    end
  end
end
