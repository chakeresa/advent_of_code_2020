defmodule PasswordTest do
  use ExUnit.Case

  describe "part 1" do
    test "works for the example data" do
      assert Password.part_1([
               "1-3 a: abcde",
               "1-3 b: cdefg",
               "2-9 c: ccccccccc"
             ]) == 2
    end

    test "works for the real data" do
      assert Password.part_1() == 524
    end
  end

  describe "part 2" do
    test "works for the example data" do
      assert Password.part_2([
               "1-3 a: abcde",
               "1-3 b: cdefg",
               "2-9 c: ccccccccc"
             ]) == 1
    end

    test "works for the real data" do
      assert Password.part_2() == 485
    end
  end
end
