defmodule StatistiqsTest do
  use ExUnit.Case
  doctest Statistiqs

  @data [100, 60, 70, 900, 100, 200, 500, 500, 503, 600, 1000, 1200]

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
end
