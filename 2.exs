require AOC.Solver2

filepath = "./2.in"
first_answer = AOC.Solver2.solve_by_assumed_rules(filepath)
second_answer = AOC.Solver2.solve_by_rules(filepath)

IO.puts("assumed points: " <> Integer.to_string(first_answer))
IO.puts("real points: " <> Integer.to_string(second_answer))
