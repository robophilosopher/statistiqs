defmodule StatistiqsTest do
  use ExUnit.Case
  doctest Statistiqs

  @data [100, 60, 70, 900, 100, 200, 500, 500, 503, 600, 1000, 1200]
  @frequency_table %{60 => 1, 70 => 1, 100 => 2, 200 => 1, 500 => 2, 503 => 1, 600 => 1, 900 => 1, 1000 => 1, 1200 => 1}

  test "mean returns 0 for an empty list" do
    assert Statistiqs.mean([]) == 0
  end

  test "mean returns an accurate measure" do
    assert Statistiqs.mean(@data) == 477.75
  end

  test "median returns 0 for an empty list" do
    assert Statistiqs.median([]) == 0
  end

  test "median returns an accurate measure" do
    assert Statistiqs.median(@data) == 500.0
  end

  test "mode return 0 for an empty list" do
    assert Statistiqs.mode([]) == nil
  end

  test "frequency_table returns accurate frequency table" do
    assert Statistiqs.frequency_table(@data) == @frequency_table
  end

  test "modes returns accurate measure" do
    assert Statistiqs.mode(@data) == [100, 500]
  end
end
