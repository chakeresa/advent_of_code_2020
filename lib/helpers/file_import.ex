defmodule FileImport do
  def list_of_lines(filepath) do
    filepath
    |> file_to_str()
    |> String.split("\n")
  end

  def list_of_line_chunks(filepath) do
    filepath
    |> file_to_str()
    |> String.split("\n\n")
  end

  def file_to_str(filepath) do
    filepath
    |> File.read!()
    |> String.trim_trailing()
  end
end
