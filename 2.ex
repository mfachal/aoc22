  defmodule AOC.Solver2 do
    require AOC.Helper

    @win_states [
      {:paper, :rock},
      {:rock, :scissors},
      {:scissors, :paper}
    ]

    @points_per_output %{
      lose: 0,
      draw: 3,
      win: 6,
      is_rock: 1,
      is_paper: 2,
      is_scissors: 3
    }

    defp end_conditions, do: %{
      win: fn x, y -> {x, y} in @win_states end,
      draw: fn x, y -> x == y end,
      lose: fn x, y -> not ({x, y} in @win_states or x == y) end, # Technically we could just do true since it's 0 points
      is_rock: fn x, _y -> x == :rock end,
      is_scissors: fn x, _y -> x == :scissors end,
      is_paper: fn x, _y -> x == :paper end
    }

    @translation_dict %{
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors,
      "X" => :rock,
      "Y" => :paper,
      "Z" => :scissors
    }

    def solve(file) do
      {:ok, guide} = File.read(file)
      strat_points = guide
        |> String.split("\n", trim: true)
        |> Enum.map(fn strat_step -> String.split(strat_step, " ", trim: true) end)
        |> Enum.map(fn [s_theirs, s_mine] -> {@translation_dict[s_mine], @translation_dict[s_theirs]} end)
        |> Enum.map(&points/1)
        |> Enum.sum()
      strat_points
    end

    defp points({mine, theirs}) do
      # Given a tuple, checks the points according to conditions
      points = end_conditions()
        |> Enum.map(fn {condt, check} -> {condt, check.(mine, theirs)} end)
        |> Enum.filter(fn {_condt, check} -> check end)
        |> Enum.map(fn {condt, _true} -> @points_per_output[condt] end)
        |> Enum.sum()
      points
    end
  end
