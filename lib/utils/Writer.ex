defmodule Aoc20.Utils.Writer do
  @moduledoc false

  @type file_type :: :input | :code | :test

  @spec write(tuple) :: String.t()
  def write({day} = data) do
    IO.puts("here")
    code_content = EEx.eval_file("lib/utils/templates/src.eex", day: day)
    test_content = EEx.eval_file("lib/utils/templates/test.eex", day: day)

    data_file = path_for(data, :input) |> write_unless_exists()
    code_file = path_for(data, :code) |> write_unless_exists(code_content)
    test_file = path_for(data, :test) |> write_unless_exists(test_content)

    output({data_file, code_file, test_file})
  end

  @spec path_for({any}, file_type) :: Path.t()
  defp path_for({day}, :input), do: "input/day#{day}.txt"
  defp path_for({day}, :code), do: "lib/day#{day}.ex"
  defp path_for({day}, :test), do: "test/day#{day}_test.exs"

  @spec write_unless_exists(String.t(), iodata) :: :ok | {:error, File.posix()}
  defp write_unless_exists(path, content \\ "") do
    unless File.exists?(path), do: File.write(path, content)
  end

  @spec output(tuple) :: String.t()
  defp output({input, code, test}) do
    report = fn
      :ok -> "Yes"
      _ -> "No"
    end

    "Input: #{report.(input)}, code: #{report.(code)}, test: #{report.(test)}\n"
  end
end
