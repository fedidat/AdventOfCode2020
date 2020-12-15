defmodule Aoc20.Utils.Reader do
  @moduledoc """
  Reads AOC input
  """

  defmacro __using__(day: day) do
    quote do
      defp build_path(day), do: "input/day#{day}.txt"

      def read!(day) do
        build_path(day) |> File.read!()
      end

      def input!, do: read!(unquote(day)) |> String.trim()
    end
  end
end
