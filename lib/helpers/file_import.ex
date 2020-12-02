defmodule FileImport do
  def list_of_lines(filepath) do
    filepath
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n")
  end
end
