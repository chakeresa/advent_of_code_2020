defmodule BaggageTest do
  use ExUnit.Case

  @sample_input [
    "light red bags contain 1 bright white bag, 2 muted yellow bags.",
    "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
    "bright white bags contain 1 shiny gold bag.",
    "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
    "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
    "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
    "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
    "faded blue bags contain no other bags.",
    "dotted black bags contain no other bags."
  ]

  describe "part 1 - count_bag_colors_holding_a_shiny_gold_bag" do
    test "works for the sample data" do
      assert Baggage.count_bag_colors_holding_a_shiny_gold_bag(@sample_input) == 4
    end

    test "works for the actual data" do
      assert Baggage.count_bag_colors_holding_a_shiny_gold_bag() == 177
    end
  end

  describe "contains?" do
    test "returns true if the Baggage can hold the specified type" do
      bag = %Baggage{
        type: "light red",
        children: [
          %Baggage{
            count: 1,
            type: "bright white",
            children: [
              %Baggage{count: 1, type: "shiny gold", children: []}
            ]
          },
          %Baggage{
            count: 2,
            type: "muted yellow",
            children: [
              %Baggage{count: 2, type: "shiny gold", children: []},
              %Baggage{count: 9, type: "faded blue", children: []}
            ]
          }
        ]
      }

      assert Baggage.contains?(bag, "shiny gold")

      bag = %Baggage{
        type: "dark olive",
        children: [
          %Baggage{
            count: 3,
            type: "faded blue",
            children: []
          },
          %Baggage{
            count: 4,
            type: "dotted black",
            children: []
          }
        ]
      }

      refute Baggage.contains?(bag, "shiny gold")
    end
  end
end
