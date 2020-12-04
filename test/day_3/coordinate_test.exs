defmodule CoordinateTest do
  use ExUnit.Case

  describe "struct" do
    test "defaults to (0,0)" do
      assert %Coordinate{x: 0, y: 0} == %Coordinate{}
    end
  end
end
