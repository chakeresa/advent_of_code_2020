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
      slopes = [5, 3]

      assert Toboggan.new(@pattern, slopes) == %Toboggan{
               pattern: @pattern,
               current_coord: starting_coord,
               hits: 0,
               slopes: slopes
             }
    end
  end

  describe "next_coord" do
    test "returns the next coordinate (within input pattern)" do
      initial = %Toboggan{
        pattern: @pattern,
        current_coord: %Coordinate{x: 1, y: 1},
        slopes: [3, 1]
      }

      assert %Coordinate{x: 4, y: 2} = Toboggan.next_coord(initial)
    end

    test "returns the next coordinate (outside the input pattern to the right)" do
      initial = %Toboggan{
        pattern: @pattern,
        current_coord: %Coordinate{x: 1, y: 1},
        slopes: [5, 1]
      }

      assert %Coordinate{x: 1, y: 2} = Toboggan.next_coord(initial)
    end

    test "returns nil if already on the last row" do
      initial = %Toboggan{
        pattern: @pattern,
        current_coord: %Coordinate{x: 1, y: 3},
        slopes: [5, 1]
      }

      assert is_nil(Toboggan.next_coord(initial))
    end
  end

  describe "next" do
    test "moves from one spot to the next and increments hit (if hit)" do
      initial = %Toboggan{
        pattern: Pattern.new(["...", "...", "..#"]),
        current_coord: %Coordinate{x: 0, y: 1},
        slopes: [2, 1],
        hits: 1
      }

      assert %Toboggan{current_coord: %Coordinate{x: 2, y: 2}, hits: 2} = Toboggan.next(initial)
    end

    test "moves from one spot to the next and does not change hits (if not hit)" do
      initial = %Toboggan{
        pattern: Pattern.new(["...", "...", "..#"]),
        current_coord: %Coordinate{x: 0, y: 1},
        slopes: [1, 1],
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

  describe "part 2" do
    test "works for the example data" do
      assert Toboggan.product_of_slope_hits(
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
               [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
             ) == 336
    end

    test "works for the real data" do
      assert Toboggan.product_of_slope_hits([[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]) ==
               3_772_314_000
    end
  end
end
