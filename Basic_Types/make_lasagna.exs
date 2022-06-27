#First Exercise: Make Lasagna - Basic Operations

defmodule Lasagna do
  def expected_minutes_in_oven do
    40
  end

  def remaining_minutes_in_oven(remain) do
    expected_minutes_in_oven() - remain
  end

  def preparation_time_in_minutes(layers) do
    layers * 2
  end

  def total_time_in_minutes(layers, minutes) do
    preparation_time_in_minutes(layers) + minutes
  end

  def alarm() do
    "Ding!"
  end
end
