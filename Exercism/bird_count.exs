# Exercise # 12 - Bird Count - Recursion


defmodule BirdCount do
  def today([]), do: nil
  def today(list) do
    hd(list)
  end

  def increment_day_count([]), do: [1]
  def increment_day_count(list) do
    [head | tail] = list
    [(head + 1) | tail]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([head | tail]) do
    cond do
      head == 0 -> true
      true -> has_day_without_birds?(tail)
    end
  end

  def total([]), do: 0
  def total([head | tail]) do
    head + total(tail)
  end

  def busy_days([]), do: 0
  def busy_days([head | tail]) when head >= 5 do
    1 + busy_days(tail)
  end
  def busy_days([head | tail]) when head < 5 do
    busy_days(tail)
  end
end
