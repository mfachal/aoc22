defmodule AOC.Helper do
  def list_to_ints(x) do
    Enum.map(x, &String.to_integer/1)
  end
end
