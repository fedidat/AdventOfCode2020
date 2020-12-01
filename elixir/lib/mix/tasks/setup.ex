defmodule Mix.Tasks.Setup do
  @moduledoc """
  Creates input, lib and test files for a given day.
  """

  alias Aoc20.Utils.{Writer}
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    Writer.write({args})
    |> Mix.shell().info()
  end
end
