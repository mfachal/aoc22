defmodule AOC.Solver1 do
    require AOC.Helper

    def solve(file) do
      {:ok, calories} = File.read(file)
      tcals = calories
        |> String.split("\n\n", trim: true)
        |> Enum.map(fn s -> String.split(s, "\n", trim: true) end)
        |> Enum.map(&AOC.Helper.list_to_ints/1)
        |> Enum.map(fn x -> List.foldr(x, 0, fn a, b -> a+b end) end)

      top1 = tcals
        |> Enum.max()

      top3 = tcals
        |> Enum.sort(:desc)
        |> Enum.take(3)
        |> Enum.sum()

      IO.puts("max: " <> Integer.to_string(top1))
      IO.puts("top3 sum: " <> Integer.to_string(top3))

      {top1, top3}
    end
  end
