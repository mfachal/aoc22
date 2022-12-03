require AOC.Solver2

filepath = "./2.in"
answer = AOC.Solver2.solve(filepath)

IO.puts("total points: " <> Integer.to_string(answer))
