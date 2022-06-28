#First Exercise: Make Lasagna - Basic Operations

# In this exercise you're going to write some code to help you cook a brilliant lasagna from your favorite cooking book.

# You have five tasks, all related to the time spent cooking the lasagna.

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
