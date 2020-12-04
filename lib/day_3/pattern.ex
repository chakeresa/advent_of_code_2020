defmodule Pattern do
  @tree_character "#"

  defstruct [:input, :width, :height]

  def new(list_of_lines) do
    %__MODULE__{
      input: list_of_lines,
      width: width(list_of_lines),
      height: height(list_of_lines)
    }
  end

  @doc "starting at one"
  def width([first_line | _rest]) do
    String.length(first_line)
  end

  @doc "starting at one"
  def height(list_of_lines) do
    length(list_of_lines)
  end

  def tree?(_pattern, nil), do: false

  def tree?(%__MODULE__{input: input}, %Coordinate{x: x, y: y}) do
    input
    |> Enum.at(y)
    |> String.graphemes()
    |> Enum.at(x)
    |> Kernel.==(@tree_character)
  end
end
