defmodule AOC.Tester do
  require AOC.Solver1
  require AOC.Solver2

  def test_1() do
    AOC.Solver1.solve("./1.tin")
    |> IO.inspect(label: "1")
  end

  def test_2() do
    AOC.Solver2.solve_by_assumed_rules("./2.tin")
    |> IO.inspect(label: "2.1")

    AOC.Solver2.solve_by_rules("./2.tin")
    |> IO.inspect(label: "2.2")
  end
end

#AOC.Tester.test_1()
AOC.Tester.test_2()
