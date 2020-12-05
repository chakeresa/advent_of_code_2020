defmodule RecursionTest do
  use ExUnit.Case

  describe "part 1 - finds the base' name" do
    test "works for the sample data" do
      input = [
        "pbga (66)",
        "xhth (57)",
        "ebii (61)",
        "havc (66)",
        "ktlj (57)",
        "fwft (72) -> ktlj, cntj, xhth",
        "qoyq (66)",
        "padx (45) -> pbga, havc, qoyq",
        "tknk (41) -> ugml, padx, fwft",
        "jptl (61)",
        "ugml (68) -> gyxo, ebii, jptl",
        "gyxo (61)",
        "cntj (57)"
      ]

      assert Recursion.base_name(input) == "tknk"
    end

    test "works for the real data" do
      assert Recursion.base_name() == "ykpsek"
    end
  end

  describe "part 2" do
    test "works for the sample data" do
      input = [
        "pbga (66)",
        "xhth (57)",
        "ebii (61)",
        "havc (66)",
        "ktlj (57)",
        "fwft (72) -> ktlj, cntj, xhth",
        "qoyq (66)",
        "padx (45) -> pbga, havc, qoyq",
        "tknk (41) -> ugml, padx, fwft",
        "jptl (61)",
        "ugml (68) -> gyxo, ebii, jptl",
        "gyxo (61)",
        "cntj (57)"
      ]

      assert Recursion.part_2(input) == 60
    end

    test "works for the real data" do
      assert Recursion.part_2() == 1060
    end
  end

  describe "create_disc" do
    test "constructs a tree of all data down from the named disc" do
      input = [
        "pbga (66)",
        "xhth (57)",
        "ebii (61)",
        "havc (66)",
        "ktlj (57)",
        "fwft (72) -> ktlj, cntj, xhth",
        "qoyq (66)",
        "padx (45) -> pbga, havc, qoyq",
        "tknk (41) -> ugml, padx, fwft",
        "jptl (61)",
        "ugml (68) -> gyxo, ebii, jptl",
        "gyxo (61)",
        "cntj (57)"
      ]

      assert input
             |> Recursion.parse_lines_to_map()
             |> Recursion.create_disc("tknk") == %Disc{
               name: "tknk",
               weight: 41,
               children: [
                 %Disc{
                   name: "ugml",
                   weight: 68,
                   children: [
                     %Disc{name: "gyxo", weight: 61, children: []},
                     %Disc{name: "ebii", weight: 61, children: []},
                     %Disc{name: "jptl", weight: 61, children: []}
                   ]
                 },
                 %Disc{
                   name: "padx",
                   weight: 45,
                   children: [
                     %Disc{name: "pbga", weight: 66, children: []},
                     %Disc{name: "havc", weight: 66, children: []},
                     %Disc{name: "qoyq", weight: 66, children: []}
                   ]
                 },
                 %Disc{
                   name: "fwft",
                   weight: 72,
                   children: [
                     %Disc{name: "ktlj", weight: 57, children: []},
                     %Disc{name: "cntj", weight: 57, children: []},
                     %Disc{name: "xhth", weight: 57, children: []}
                   ]
                 }
               ]
             }
    end
  end
end
