defmodule Aoc20.Day1 do
  @moduledoc """
  https://adventofcode.com/2020/day/1
  """
  use Aoc20.Utils.Reader, day: 1

  def process(input \\ input!()) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.into([])
  end

  def part1 do
    input = process()
    first = input
    |> Enum.find(fn x -> Enum.find(input, fn y -> x + y == 2020 end) end)
    second = input
    |> Enum.find(fn x -> x + first == 2020 end)
    first * second
  end

  def part2 do
    input = process()
    first = input
    |> Enum.find(fn x -> Enum.find(input, fn y -> Enum.find(input, fn z -> x + y + z == 2020 end) end) end)
    second = input
    |> Enum.find(fn x -> Enum.find(input, fn y -> x + y + first == 2020 end) end)
    third = input
    |> Enum.find(fn x -> x + first + second == 2020 end)
    first * second * third
  end

  def start(_type, _args) do
    IO.puts("Part 1: #{part1()}")
    IO.puts("Part 2: #{part2()}")
  end
end
