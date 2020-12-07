defmodule FileImport do
  def list_of_lines(filepath) do
    filepath
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n")
  end

  def list_of_line_chunks(filepath) do
    filepath
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n\n")
  end
end
