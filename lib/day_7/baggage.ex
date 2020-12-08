defmodule Baggage do
  @list_of_lines_from_txt FileImport.list_of_lines("lib/day_7/data.txt")

  defstruct [:type, count: 0, children: []]

  @doc """
  You land at the regional airport in time for your next flight. In fact, it
  looks like you'll even have time to grab some food: all flights are currently
  delayed due to issues in luggage processing.

  Due to recent aviation regulations, many rules (your puzzle input) are being
  enforced about bags and their contents; bags must be color-coded and must
  contain specific quantities of other color-coded bags. Apparently, nobody
  responsible for these regulations considered how long they would take to
  enforce!

  For example, consider the following rules:
  ```
  light red bags contain 1 bright white bag, 2 muted yellow bags.
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  bright white bags contain 1 shiny gold bag.
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  faded blue bags contain no other bags.
  dotted black bags contain no other bags.
  ```
  These rules specify the required contents for 9 bag types. In this example,
  every faded blue bag is empty, every vibrant plum bag contains 11 bags (5
  faded blue and 6 dotted black), and so on.

  You have a shiny gold bag. If you wanted to carry it in at least one other
  bag, how many different bag colors would be valid for the outermost bag? (In
  other words: how many colors can, eventually, contain at least one shiny gold
  bag?)

  In the above rules, the following options would be available to you:
  - A bright white bag, which can hold your shiny gold bag directly.
  - A muted yellow bag, which can hold your shiny gold bag directly, plus some
  other bags.
  - A dark orange bag, which can hold bright white and muted yellow bags,
  either of which could then hold your shiny gold bag.
  - A light red bag, which can hold bright white and muted yellow bags, either
  of which could then hold your shiny gold bag.

  So, in this example, the number of bag colors that can eventually contain at
  least one shiny gold bag is 4.

  How many bag colors can eventually contain at least one shiny gold bag? (The
  list of rules is quite long; make sure you get all of it.)

  Your puzzle answer was 177.
  """
  def count_bag_colors_holding_a_shiny_gold_bag(list_of_lines \\ @list_of_lines_from_txt) do
    list_of_lines
    |> parse_lines_to_map()
    |> parse_map_to_structs()
    |> Enum.filter(&contains?(&1, "shiny gold"))
    |> Enum.count()
  end

  def parse_lines_to_map(list_of_lines) do
    list_of_lines
    |> Enum.map(fn line ->
      captures =
        Regex.named_captures(
          ~r/^(?<type>.+) bags contain (?<children_str>.*)/,
          line
        )

      type = Map.get(captures, "type")

      children_types =
        captures
        |> Map.get("children_str")
        |> case do
          "no other bags." -> []
          children_str -> split_children_str(children_str)
        end

      {type, children_types}
    end)
    |> Enum.into(%{})
  end

  def split_children_str(children_str) when is_binary(children_str) do
    children_str
    |> String.replace(".", "")
    |> String.split(", ")
    |> Enum.map(fn child_str ->
      Regex.named_captures(
        ~r/^(?<count>\d+) (?<type>.*) bag(s)?/,
        child_str
      )
    end)
  end

  @doc """
  example input:
  ```
  %{
      "bright white" => [%{"count" => "1", "type" => "shiny gold"}],
      "dark olive" => [%{"count" => "3", "type" => "faded blue"}, %{"count" => "4", "type" => "dotted black"}],
      "dark orange" => [%{"count" => "3", "type" => "bright white"}, %{"count" => "4", "type" => "muted yellow"}],
      "dotted black" => [],
      "faded blue" => [],
      "light red" => [%{"count" => "1", "type" => "bright white"}, %{"count" => "2", "type" => "muted yellow"}],
      "muted yellow" => [%{"count" => "2", "type" => "shiny gold"}, %{"count" => "9", "type" => "faded blue"}],
      "shiny gold" => [%{"count" => "1", "type" => "dark olive"}, %{"count" => "2", "type" => "vibrant plum"}],
      "vibrant plum" => [%{"count" => "5", "type" => "faded blue"}, %{"count" => "6", "type" => "dotted black"}]
    }
  ```
  """
  def parse_map_to_structs(type_to_children_map) do
    type_to_children_map
    |> Enum.map(fn {parent_type, list_of_child_maps} ->
      %__MODULE__{
        type: parent_type,
        children: Enum.map(list_of_child_maps, &build_baggage(&1, type_to_children_map))
      }
    end)
  end

  def build_baggage(%{"count" => count, "type" => type}, type_to_children_map) do
    children =
      type_to_children_map
      |> Map.get(type)
      |> Enum.map(&build_baggage(&1, type_to_children_map))

    %__MODULE__{count: count, type: type, children: children}
  end

  def contains?(%__MODULE__{children: []}, _type_to_look_for), do: false

  def contains?(%__MODULE__{children: children}, type_to_look_for) do
    Enum.any?(children, fn child ->
      child.type == type_to_look_for ||
        contains?(child, type_to_look_for)
    end)
  end
end
