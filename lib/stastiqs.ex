defmodule Statistiqs do

  def sum_list(list), do: Enum.reduce(list,0, &(&1 + &2))
  def mean([]), do: 0
  def mean(list), do: sum_list(list)/length(list)

  def median([]), do: 0
  def median(list) do
    midpoint = Enum.count(list) |> div(2)
    list
    |> Enum.sort
    |> Enum.at(midpoint)
  end
end
