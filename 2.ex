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

    @end_conditions %{
      win: fn x, y -> {x, y} in @win_states end,
      draw: fn x, y -> x == y end,
      lose: fn x, y -> not ({x, y} in @win_states or x == y) end, # Technically we could just do true since it's 0 points
      is_rock: fn x, y -> x == :rock end,
      is_scissors: fn x, y -> x == :scissors end,
      is_paper: fn x, y -> x == :paper end
    }

    @translation_dict %{
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors,
      "X" => :rock,
      "Y" => :paper,
      "Z" => :scissors
    }


    def solve2(file) do
      {:ok, guide} = File.read(file)
      strat = guide
      |> String.split("\n", trim: true)
      |> Enum.map(fn strat_step -> String.split(strat_step, " ", trim: true) end)
      |> Enum.map(fn [s_mine, s_theirs] -> {@translation_dict[s_mine], @translation_dict[s_theirs]} end)
      |> Enum.map(&e2_points/1)


    end


    defp e2_points(play = {mine, theirs}) do
      # Given a tuple, checks the points according to conditions
      points = @end_conditions
        |> Enum.map(fn {condt, check} -> {condt, check.(mine, theirs)} end)
        |> Enum.filter(fn {condt, check} -> check end)
        |> Enum.map(fn {condt, _true} -> @points_per_output[condt] end)
        |> Enum.sum()
    end
  end
