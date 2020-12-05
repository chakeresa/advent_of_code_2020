defmodule Recursion do
  @list_of_lines_from_txt FileImport.list_of_lines("lib/other_years/2017/day_7/data.txt")

  @doc """
  Wandering further through the circuits of the computer, you come upon a tower
  of programs that have gotten themselves into a bit of trouble. A recursive
  algorithm has gotten out of hand, and now they're balanced precariously in a
  large tower.

  One program at the bottom supports the entire tower. It's holding a large
  disc, and on the disc are balanced several more sub-towers. At the bottom of
  these sub-towers, standing on the bottom disc, are other programs, each
  holding their own disc, and so on. At the very tops of these sub-sub-sub-...
  -towers, many programs stand simply keeping the disc below them balanced but
  with no disc of their own.

  You offer to help, but first you need to understand the structure of these
  towers. You ask each program to yell out their name, their weight, and (if
  they're holding a disc) the names of the programs immediately above them
  balancing on that disc. You write this information down (your puzzle input).
  Unfortunately, in their panic, they don't do this in an orderly fashion; by
  the time you're done, you're not sure which program gave which information.

  For example, if your list is the following:
  ```
  pbga (66)
  xhth (57)
  ebii (61)
  havc (66)
  ktlj (57)
  fwft (72) -> ktlj, cntj, xhth
  qoyq (66)
  padx (45) -> pbga, havc, qoyq
  tknk (41) -> ugml, padx, fwft
  jptl (61)
  ugml (68) -> gyxo, ebii, jptl
  gyxo (61)
  cntj (57)
  ```
  ...then you would be able to recreate the structure of the towers that looks
  like this:
  ```
                gyxo
              /
         ugml - ebii
       /      \
      |         jptl
      |
      |         pbga
     /        /
  tknk --- padx - havc
     \        \
      |         qoyq
      |
      |         ktlj
       \      /
         fwft - cntj
              \
                xhth
                ```
  In this example, tknk is at the bottom of the tower (the bottom program), and
  is holding up ugml, padx, and fwft. Those programs are, in turn, holding up
  other programs; in this example, none of those programs are holding up any
  other programs, and are all the tops of their own towers. (The actual tower
  balancing in front of you is much larger.)

  Before you're ready to help them, you need to make sure your information is
  correct. What is the name of the bottom program?

  Your puzzle answer was ykpsek.
  """
  def base_name(list_of_lines \\ @list_of_lines_from_txt) do
    full_input = Enum.join(list_of_lines, "\n")

    list_of_lines
    |> Enum.find(fn line ->
      name = first_word(line)
      !String.match?(full_input, ~r/.*#{name}.*#{name}.*/s)
    end)
    |> first_word()
  end

  def first_word(line) do
    line
    |> String.split()
    |> List.first()
  end

  def part_2(list_of_lines \\ @list_of_lines_from_txt) do
    list_of_lines
    |> build_tower()
    |> find_unbalanced()
    |> get_totals()
    |> get_answer
  end

  def get_totals(%Disc{children: children}) do
    Enum.group_by(children, fn %Disc{} = child ->
      Disc.total_weight(child)
    end)
  end

  def get_answer(counts_and_discs) do
    # qajub is the problem (weight 1139, total weight 1817, parent = hnafo, sibling total weights = 1817... it is balanced!!)
    %{bad_weight: bad_weight, good_weight: good_weight, disc_weight: disc_weight} =
      counts_and_discs
      |> IO.inspect()
      |> Enum.map(fn
        {bad_weight, [%Disc{weight: disc_weight}]} ->
          [{:bad_weight, bad_weight}, {:disc_weight, disc_weight}]

        {good_weight, _good_discs} ->
          {:good_weight, good_weight}
      end)
      |> List.flatten()
      |> Enum.into(%{})

    disc_weight + good_weight - bad_weight
  end

  def find_unbalanced(disc_to_check, problem_disc \\ nil)
  def find_unbalanced(nil, problem_disc), do: problem_disc

  def find_unbalanced(%Disc{children: children} = disc, _parent) do
    if Disc.balanced?(disc) do
      disc
    else
      children
      |> Enum.find(fn child ->
        !Disc.balanced?(child)
      end)
      |> find_unbalanced(disc)
    end
  end

  def build_tower(list_of_lines) do
    list_of_lines
    |> base_name()
    |> create_disc(list_of_lines)
  end

  def create_disc(name, list_of_lines) do
    line =
      Enum.find(list_of_lines, fn ln ->
        name == first_word(ln)
      end)

    case Regex.named_captures(~r/^\w+ \((?<weight>.+)\) -> (?<child_str>.+)$/, line) do
      %{"child_str" => child_str, "weight" => weight_str} ->
        children =
          child_str
          |> String.split(", ")
          |> Enum.map(&create_disc(&1, list_of_lines))

        %Disc{name: name, weight: String.to_integer(weight_str), children: children}

      _ ->
        %{"weight" => weight_str} = Regex.named_captures(~r/^\w+ \((?<weight>.+)\)$/, line)
        %Disc{name: name, weight: String.to_integer(weight_str)}
    end
  end
end
