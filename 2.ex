  defmodule AOC.Solver2 do
    require AOC.Helper

    @win_states [
      {:rock, :paper},
      {:scissors, :rock},
      {:paper, :scissors}
    ]

    @points_per_output %{
      lose: 0,
      draw: 3,
      win: 6,
      is_rock: 1,
      is_paper: 2,
      is_scissors: 3
    }

    defp assumed_end_conditions, do: %{
      win: fn x, y -> {x, y} in @win_states end,
      draw: fn x, y -> x == y end,
      lose: fn x, y -> not ({x, y} in @win_states or x == y) end, # Technically we could just do true since it's 0 points
      is_rock: fn _x, y -> y == :rock end,
      is_scissors: fn _x, y -> y == :scissors end,
      is_paper: fn _x, y -> y == :paper end
    }

    @assumed_transl %{
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors,
      "X" => :rock,
      "Y" => :paper,
      "Z" => :scissors
    }

    @real_transl %{
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors,
      "X" => :lose,
      "Y" => :draw,
      "Z" => :win
    }

    @rock_states [
      {:rock, :draw},
      {:paper, :lose},
      {:scissors, :win}
    ]

    @scissors_states [
      {:scissors, :draw},
      {:paper, :win},
      {:rock, :lose}
    ]

    @paper_states [
      {:scissors, :lose},
      {:rock, :win},
      {:paper, :draw}
    ]

    defp real_end_conditions, do: %{
      win: fn _x, y -> y == :win end,
      draw: fn _x, y -> y == :draw end,
      lose: fn _x, y -> y == :lose end,
      is_rock: fn x, y -> {x, y} in @rock_states end,
      is_scissors: fn x, y -> {x, y} in @scissors_states end,
      is_paper: fn x, y -> {x, y} in @paper_states end
    }

    def solve(filename, decoding, end_conditions) do
      {:ok, guide} = File.read(filename)
      strat_points = guide
        |> String.split("\n", trim: true)
        |> Enum.map(fn strat_step -> String.split(strat_step, " ", trim: true) end)
        |> Enum.map(fn [play1, play2] -> {decoding[play1], decoding[play2]} end)
        |> Enum.map(points(end_conditions))
        |> Enum.sum()
      strat_points
    end

    def solve_by_assumed_rules(file) do
      solve(file, @assumed_transl, &assumed_end_conditions/0)
    end

    def solve_by_rules(file) do
      solve(file, @real_transl, &real_end_conditions/0)
    end

    defp points(conditions) do
      fn {play1, play2} ->
        points = conditions.()
          |> Enum.map(fn {condt, check} -> {condt, check.(play1, play2)} end)
          |> Enum.filter(fn {_condt, check} -> check end)
          |> Enum.map(fn {condt, _true} -> @points_per_output[condt] end)
          |> Enum.sum()
        points
      end
    end
  end
