defmodule AOC.Tester do
  require AOC.Solver1

  def test_1() do
    AOC.Solver1.solve("./1.tin")
    |> IO.inspect(label: "1")
  end
end

AOC.Tester.test_1()
