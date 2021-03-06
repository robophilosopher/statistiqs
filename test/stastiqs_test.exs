defmodule StatistiqsTest do
  use ExUnit.Case
  doctest Statistiqs

  @data [100, 60, 70, 900, 100, 200, 500, 500, 503, 600, 1000, 1200]
  @frequency_table %{60 => 1, 70 => 1, 100 => 2, 200 => 1, 500 => 2, 503 => 1, 600 => 1, 900 => 1, 1000 => 1, 1200 => 1}

  test "mean returns 0 for an empty list" do
    assert Statistiqs.mean([]) == nil
  end

  test "mean returns an accurate measure" do
    assert Statistiqs.mean(@data) == 477.75
  end

  test "median returns 0 for an empty list" do
    assert Statistiqs.median([]) == nil
  end

  test "median returns an accurate measure for an odd length list" do
    data = [1,2,3,4,5]
    assert Statistiqs.median(data) == 3
  end

  test "median returns an accurate measure for an even length list" do
    data = [1,2,3,4,5,6]
    assert Statistiqs.median(data) == 3.5
  end

  test "mode return 0 for an empty list" do
    assert Statistiqs.mode([]) == nil
  end

  test "frequency_table returns accurate frequency table" do
    assert Statistiqs.frequency_table(@data) == @frequency_table
  end

  test "modes returns accurate measures when there is more than one mode in a list" do
    assert Statistiqs.mode(@data) == [100, 500]
  end

  test "mode returns accurate measure when there is only one mode in a list" do
    data = @data -- [500]
    assert Statistiqs.mode(data) == [100]
  end

  test "find_range returns lowest, highest, and range" do
    data = [100, 60, 70, 900, 100, 200, 500, 500, 503, 600, 1000, 1200]
    assert Statistiqs.find_range(data) == {60,1200, 1140}
  end

  test "variance returns correct result" do
    data = [100, 60, 70, 900, 100, 200, 500, 500, 503, 600, 1000, 1200]
    assert Statistiqs.variance(data) == 141047.35416666666
  end

  test "standard_deviation returns correct result" do
    data = [100, 60, 70, 900, 100, 200, 500, 500, 503, 600, 1000, 1200]
    assert Statistiqs.standard_deviation(data) == 375.5627166887931
  end

  test "pearson_correlation returns correct result" do
    x = [490, 500, 530, 550, 580, 590, 600, 600, 650, 700]
    y = [560, 500, 510, 600, 600, 620, 550, 630, 650, 750]
    assert Statistiqs.pearson_correlation(x, y) == 0.87
  end

  test "sum_lists raises error for lists of unequal length" do
    x = [490, 500]
    y = [560]

    assert_raise ArithmeticError, "Lists must be of the same length.", fn ->
      Statistiqs.vector_add_lists(x, y)
    end
  end

end
