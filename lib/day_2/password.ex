defmodule Password do
  @moduledoc """
  Your flight departs in a few days from the coastal airport; the easiest way down to the coast from here is via toboggan.

  The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!" You ask if you can take a look.

  Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.

  To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.

  For example, suppose you have the following list:

  1-3 a: abcde
  1-3 b: cdefg
  2-9 c: ccccccccc
  Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

  In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.

  How many passwords are valid according to their policies?

  Your puzzle answer was 524.
  """

  @line_regex ~r/(?<low>\d+)-(?<high>\d+) (?<letter>\w+): (?<password>\w+)/

  def solution() do
    list_of_lines()
    |> Enum.map(&Regex.named_captures(@line_regex, &1))
    |> Enum.map(&validate(&1))
    |> Enum.count(& &1)
  end

  def list_of_lines do
    "lib/day_2/data.txt"
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n")
  end

  def validate(%{"high" => high, "letter" => letter, "low" => low, "password" => password}) do
    count =
      password
      |> String.graphemes()
      |> Enum.count(&(&1 == letter))

    count >= String.to_integer(low) && count <= String.to_integer(high)
  end
end
