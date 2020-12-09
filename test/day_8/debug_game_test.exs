defmodule DebugGameTest do
  use ExUnit.Case

  @sample_input [
    "nop +0",
    "acc +1",
    "jmp +4",
    "acc +3",
    "jmp -3",
    "acc -99",
    "acc +1",
    "jmp -4",
    "acc +6"
  ]

  describe "part 1 - accum_when_loop_restarts" do
    test "works for the sample data" do
      assert DebugGame.accum_when_loop_restarts(@sample_input) == 5
    end

    test "works for the actual data" do
      assert DebugGame.accum_when_loop_restarts() == 2014
    end
  end
end
