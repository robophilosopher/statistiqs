defmodule Statistiqs do

  # -----------------------
  # Sum
  # -----------------------

  def sum_list([]), do: nil
  def sum_list(list), do: Enum.reduce(list, 0, &(&1 + &2))

  # -----------------------
  # Mean
  # -----------------------

  def mean([]), do: nil
  def mean(list), do: sum_list(list)/length(list)

  # -----------------------
  # Median
  # -----------------------

  def median([]), do: nil
  def median(list) do
    list_length = Enum.count(list)
    midpoint = Enum.count(list) |> div(2)

    if rem(list_length, 2) == 0 do
      mid1 = Enum.at(list, midpoint - 1)
      mid2 = Enum.at(list, midpoint)
      (mid1 + mid2) / 2
    else
      list
      |> Enum.sort
      |> Enum.at(midpoint)
    end
  end

  # -----------------------
  # Frequency Table
  # -----------------------

  def frequency_table([]), do: nil
  def frequency_table(list) do
    frequency_table(%{}, list)
  end

  defp frequency_table(map, []) do
    map
  end

  defp frequency_table(map, list) do
    [head | tail] = list

    if Map.has_key?(map, head) do
      %{ map | head => map[head] + 1}
      |> frequency_table(tail)
    else
      Map.merge(map, %{ head => 1 })
      |> frequency_table(tail)
    end
  end

  # -----------------------
  # Mode
  # -----------------------

  def mode([]), do: nil
  def mode(data) do
    frequency_table = frequency_table(data)

    max = frequency_table
      |> Map.values
      |> Enum.sort
      |> List.last

    mode(max, frequency_table)
  end

  defp mode(max, frequency_table) when is_map(frequency_table) do
    Enum.map(frequency_table, fn(e) -> mode(e, max) end)
    |> Enum.filter(fn(n) -> n end)
  end

  defp mode(tuple, max) when is_tuple(tuple) do
    list = Tuple.to_list(tuple)
    [first | last] = list

    if last == [max] do
      first
    end
  end

  # ---------------------------------------------------------------------
  # Dispersion Measures
  # ---------------------------------------------------------------------

  # ----------------------------------------------
  # Find Range
  # ----------------------------------------------

  def find_range([]), do: nil
  def find_range(list) do
    max = Enum.max(list)
    min = Enum.min(list)
    {min, max, max - min}
  end

  # ----------------------------------------------
  # Variance (borrowed from honeybadger-elixir)
  # ----------------------------------------------

  def variance([]), do: nil
  def variance(list) do
    ss = sum_of_squares(list)
    ss / Enum.count(list)
  end

  # ----------------------------------------------
  # Standard Deviation
  # ----------------------------------------------

  def standard_deviation([]), do: 0
  def standard_deviation(list) do
    variance(list)
    |> :math.sqrt
  end

  # ----------------------------------------------
  # Sum of Squares
  # ----------------------------------------------

  def sum_of_squares([]), do: 0
  def sum_of_squares(list) do
    Enum.reduce(list, 0.0, fn(x, sum) ->
      diff = x - mean(list)
      sum + (diff * diff)
    end)
  end

  # ---------------------------------------------------------------------
  # Correlation
  # ---------------------------------------------------------------------

  # ----------------------------------------------
  # Pearson Correlation
  # ----------------------------------------------

  def pearson_correlation([], []), do: 0
  def pearson_correlation(x, y) do
    ssx = sum_of_squares(x)
    ssy = sum_of_squares(y)

    sigma_x = Enum.reduce(x, fn(x, sum) -> (sum + x) end)
    sigma_y = Enum.reduce(y, fn(y, sum) -> (sum + y) end)

    xy = sum_lists(x, y)
    sigma_xy = Enum.reduce(xy, fn(xy, sum) -> (sum + xy) end)

    inter = (sigma_x * sigma_y)/Enum.count(x)
    ss_xy = (sigma_xy - inter)


    ss_xy / :math.sqrt(ssx * ssy)
    |> Float.round(2)
  end

  # ----------------------------------------------
  # Sum Lists
  # ----------------------------------------------

  def sum_lists(list), do: list

  def sum_lists(x, y) do
    list = []
    sum_lists(x, y, list)
  end

  def sum_lists(x, y, list) do
    if Enum.count(x) > 0 do
      [x_head|x_tail] = x
      [y_head|y_tail] = y

      new_list = list ++ [x_head * y_head]
      sum_lists(x_tail, y_tail, new_list)
    else
      sum_lists(list)
    end
  end
end
