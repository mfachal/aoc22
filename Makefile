cookie # fill with AOC cookie

get_inputs:
	for number in 1 2 ; do \
		curl --cookie $cookie "https://adventofcode.com/2022/day/$$number/input" --output $$number.in; \
	done


test:
	elixir -r helper.ex -r 1.ex tester.exs

run:
	elixir -r helper.ex -r 1.ex 1.exs
