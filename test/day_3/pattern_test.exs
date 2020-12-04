defmodule PatternTest do
  use ExUnit.Case

  describe "new" do
    test "initializes with a list of lines and sets dimensions" do
      input = [
        "..##",
        "#...",
        ".#.."
      ]

      assert Pattern.new(input) == %Pattern{input: input, width: 4, height: 3}
    end
  end

  describe "width" do
    test "count starts at zero" do
      assert Pattern.width([
               "..##",
               "#...",
               ".#.."
             ]) == 4
    end
  end

  describe "height" do
    test "count starts at zero" do
      assert Pattern.height([
               "..##",
               "#..."
             ]) == 2
    end
  end

  describe "tree?" do
    test "returns true if there's a tree at the coordinate, or not" do
      pattern = %Pattern{
        input: [
          ".#",
          ".."
        ]
      }

      refute Pattern.tree?(pattern, %Coordinate{x: 0, y: 0})
      refute Pattern.tree?(pattern, %Coordinate{x: 0, y: 1})
      refute Pattern.tree?(pattern, %Coordinate{x: 1, y: 1})
      assert Pattern.tree?(pattern, %Coordinate{x: 1, y: 0})
    end
  end
end
