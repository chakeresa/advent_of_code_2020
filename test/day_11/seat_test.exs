defmodule SeatTest do
  use ExUnit.Case

  @sample_input [
    "L.LL.LL.LL",
    "LLLLLLL.LL",
    "L.L.L..L..",
    "LLLL.LL.LL",
    "L.LL.LL.LL",
    "L.LLLLL.LL",
    "..L.L.....",
    "LLLLLLLLLL",
    "L.LLLLLL.L",
    "L.LLLLL.LL"
  ]

  describe "part 1 - equilibrium_occupied_seats" do
    test "works for the sample data" do
      assert Seat.equilibrium_occupied_seats(@sample_input) == 37
    end

    # takes ~45 seconds...
    @tag :skip
    test "works for the actual data" do
      assert Seat.equilibrium_occupied_seats() == 2483
    end
  end

  describe "next_grid" do
    test "returns the next grid" do
      expected_return_1 = [
        "#.##.##.##",
        "#######.##",
        "#.#.#..#..",
        "####.##.##",
        "#.##.##.##",
        "#.#####.##",
        "..#.#.....",
        "##########",
        "#.######.#",
        "#.#####.##"
      ]

      assert Seat.next_grid(@sample_input) == expected_return_1

      expected_return_2 = [
        "#.LL.L#.##",
        "#LLLLLL.L#",
        "L.L.L..L..",
        "#LLL.LL.L#",
        "#.LL.LL.LL",
        "#.LLLL#.##",
        "..L.L.....",
        "#LLLLLLLL#",
        "#.LLLLLL.L",
        "#.#LLLL.##"
      ]

      assert Seat.next_grid(expected_return_1) == expected_return_2

      expected_return_3 = [
        "#.##.L#.##",
        "#L###LL.L#",
        "L.#.#..#..",
        "#L##.##.L#",
        "#.##.LL.LL",
        "#.###L#.##",
        "..#.#.....",
        "#L######L#",
        "#.LL###L.L",
        "#.#L###.##"
      ]

      assert Seat.next_grid(expected_return_2) == expected_return_3

      expected_return_4 = [
        "#.#L.L#.##",
        "#LLL#LL.L#",
        "L.L.L..#..",
        "#LLL.##.L#",
        "#.LL.LL.LL",
        "#.LL#L#.##",
        "..L.L.....",
        "#L#LLLL#L#",
        "#.LLLLLL.L",
        "#.#L#L#.##"
      ]

      assert Seat.next_grid(expected_return_3) == expected_return_4

      expected_return_5 = [
        "#.#L.L#.##",
        "#LLL#LL.L#",
        "L.#.L..#..",
        "#L##.##.L#",
        "#.#L.LL.LL",
        "#.#L#L#.##",
        "..L.L.....",
        "#L#L##L#L#",
        "#.LLLLLL.L",
        "#.#L#L#.##"
      ]

      assert Seat.next_grid(expected_return_4) == expected_return_5
      assert Seat.next_grid(expected_return_5) == expected_return_5
    end
  end

  describe "neighbors" do
    test "returns a list of the neighboring characters" do
      list_of_lines = [
        "#.LL.L#.##",
        "#LLLLLL.L#",
        "L.L.L..L..",
        "#LLL.LL.L#",
        "#.LL.LL.LL",
        "#.LLLL#.##",
        "..L.L.....",
        "#LLLLLLLL#",
        "#.LLLLLL.L",
        "#.#LLLL.##"
      ]

      assert Seat.neighbors(list_of_lines, 0, 0) == [".", "#", "L"]
      assert Seat.neighbors(list_of_lines, 1, 0) == ["#", ".", "L", "L", "."]
      assert Seat.neighbors(list_of_lines, 0, 1) == ["#", "L", "#", "L", "L"]
      assert Seat.neighbors(list_of_lines, 1, 1) == ["#", ".", "L", "#", "L", "L", ".", "L"]
      assert Seat.neighbors(list_of_lines, 0, 9) == ["#", "L", "#"]
      assert Seat.neighbors(list_of_lines, 9, 9) == [".", "L", "#"]
    end
  end

  describe "continue_until_equilibrium" do
    test "returns the equilibrium list of lines" do
      assert Seat.continue_until_equilibrium(@sample_input) == [
               "#.#L.L#.##",
               "#LLL#LL.L#",
               "L.#.L..#..",
               "#L##.##.L#",
               "#.#L.LL.LL",
               "#.#L#L#.##",
               "..L.L.....",
               "#L#L##L#L#",
               "#.LLLLLL.L",
               "#.#L#L#.##"
             ]
    end
  end
end
