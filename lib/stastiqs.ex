defmodule Statistiqs do

  def sum_list(list), do: Enum.reduce(list, 0, &(&1 + &2))
  def mean([]), do: 0
  def mean(list), do: sum_list(list)/length(list)

  def median([]), do: 0
  def median(list) do
    midpoint = Enum.count(list) |> div(2)
    list
    |> Enum.sort
    |> Enum.at(midpoint)
  end

  def mode([]), do: nil

  # Finds repeating values, but does not yet find the modes
  # def mode(list) do
  #   list
  #   |> Enum.sort
  #   |> Statistiqs.head_tail_head_comparison
  # end

  # TODO: make this private
  def head_tail_head_comparison(list) do
    head_tail_head_comparison([], list)
  end

  defp head_tail_head_comparison(collection, []) do
    Enum.sort(collection)
  end

  defp head_tail_head_comparison(collection, list) do
    [head | tail] = list
    tail_head = tail_head(tail)

    if head == tail_head do
      Enum.into(collection, [head])
      |> head_tail_head_comparison(tail)
    else
      head_tail_head_comparison(collection, tail)
    end
  end

  defp tail_head([head|_]) do
    head
  end

  defp tail_head([]) do
    nil
  end

end
