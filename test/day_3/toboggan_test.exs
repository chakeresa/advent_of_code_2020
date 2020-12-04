defmodule TobogganTest do
  use ExUnit.Case

  @pattern Pattern.new([
             "..##.",
             "#...#",
             ".#...",
             "..#.#"
           ])

  describe "new" do
    test "passes in the pattern with other params at starting point" do
      starting_coord = %Coordinate{}

      assert Toboggan.new(@pattern, 5) == %Toboggan{
               pattern: @pattern,
               current_coord: starting_coord,
               hits: 0,
               slope: 5
             }
    end
  end

  describe "next_coord" do
    test "returns the next coordinate (within input pattern)" do
      initial = %Toboggan{
        pattern: @pattern,
        current_coord: %Coordinate{x: 1, y: 1},
        slope: 3
      }

      assert %Coordinate{x: 4, y: 2} = Toboggan.next_coord(initial)
    end

    test "returns the next coordinate (outside the input pattern to the right)" do
      initial = %Toboggan{
        pattern: @pattern,
        current_coord: %Coordinate{x: 1, y: 1},
        slope: 5
      }

      assert %Coordinate{x: 1, y: 2} = Toboggan.next_coord(initial)
    end

    test "returns nil if already on the last row" do
      initial = %Toboggan{
        pattern: @pattern,
        current_coord: %Coordinate{x: 1, y: 3},
        slope: 5
      }

      assert is_nil(Toboggan.next_coord(initial))
    end
  end

  describe "next" do
    test "moves from one spot to the next and increments hit (if hit)" do
      initial = %Toboggan{
        pattern: Pattern.new(["...", "...", "..#"]),
        current_coord: %Coordinate{x: 0, y: 1},
        slope: 2,
        hits: 1
      }

      assert %Toboggan{current_coord: %Coordinate{x: 2, y: 2}, hits: 2} = Toboggan.next(initial)
    end

    test "moves from one spot to the next and does not change hits (if not hit)" do
      initial = %Toboggan{
        pattern: Pattern.new(["...", "...", "..#"]),
        current_coord: %Coordinate{x: 0, y: 1},
        slope: 1,
        hits: 1
      }

      assert %Toboggan{current_coord: %Coordinate{x: 1, y: 2}, hits: 1} = Toboggan.next(initial)
    end
  end

  describe "part 1" do
    test "works for the example data" do
      assert Toboggan.hits_at_slope(
               [
                 "..##.......",
                 "#...#...#..",
                 ".#....#..#.",
                 "..#.#...#.#",
                 ".#...##..#.",
                 "..#.##.....",
                 ".#.#.#....#",
                 ".#........#",
                 "#.##...#...",
                 "#...##....#",
                 ".#..#...#.#"
               ],
               3
             ) == 7
    end

    test "works for the real data" do
      assert Toboggan.hits_at_slope(3) == 195
    end
  end
end
