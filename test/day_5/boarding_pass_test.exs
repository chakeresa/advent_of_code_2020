defmodule BoardingPassTest do
  use ExUnit.Case

  describe "part 1: highest_seat_id" do
    test "works for the sample data" do
      assert BoardingPass.highest_seat_id([
               "FBFBBFFRLR",
               "BFFFBBFRRR",
               "FFFBBBFRRR",
               "BBFFBBFRLL"
             ]) == 820
    end

    test "works for the real data" do
      assert BoardingPass.highest_seat_id() == 42
    end
  end

  describe "seat_id" do
    test "returns the seat ID for the string" do
      assert BoardingPass.seat_id("FBFBBFFRLR") == 357
      assert BoardingPass.seat_id("BFFFBBFRRR") == 567
      assert BoardingPass.seat_id("FFFBBBFRRR") == 119
      assert BoardingPass.seat_id("BBFFBBFRLL") == 820
    end
  end

  describe "row" do
    test "returns the row number for the string" do
      assert BoardingPass.row("FBFBBFFRLR") == 44
      assert BoardingPass.row("BFFFBBFRRR") == 70
      assert BoardingPass.row("FFFBBBFRRR") == 14
      assert BoardingPass.row("BBFFBBFRLL") == 102
    end
  end

  describe "column" do
    test "returns the column number for the string" do
      assert BoardingPass.column("FBFBBFFRLR") == 5
      assert BoardingPass.column("BFFFBBFRRR") == 7
      assert BoardingPass.column("FFFBBBFRRR") == 7
      assert BoardingPass.column("BBFFBBFRLL") == 4
    end
  end
end
