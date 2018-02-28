defmodule FileReader do
  @moduledoc """
  File utils to handle write.
  """
  @output_suffix "_output"

  @doc """
  Validates file throws error when file is not found or file size is empty.
  """
  def validateFile(path) do
    case File.stat(path) do
      {:ok, %{size: size}} when size > 0 -> path
      {:error, _} -> raise ArgumentError, message: "#{path} -> file not found"
      {_, _} -> raise ArgumentError, message: "#{path} -> file is empty"
    end
  end

  @doc """
  Validates file and returns the stream.
  """
  def readFile(path) do
    path
    |> validateFile()
    |> File.stream!()
  end

  defp getOutputPath(path) do
    Path.absname(Path.rootname(path) <> @output_suffix <> Path.extname(path))
  end

  @doc """
  Writes to a file with _output appended at the filename and prints on console.
  """
  def writeToFile(content, path) do
    path
    |> getOutputPath
    |> File.write!(content)

    IO.puts(content)
  end
end
