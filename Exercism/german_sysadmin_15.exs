# Exercise - 15 - German Sysadmin - case , charlist


defmodule Username do
  def sanitize([]), do: []
  def sanitize([head | tail]) do
    case head do
      head when head >= ?a and head <= ?z -> [head | sanitize(tail)]
      head when head == ?_ -> [head | sanitize(tail)]
      head when head == ?ä -> [?a,?e | sanitize(tail)]
      head when head == ?ö -> [?o,?e | sanitize(tail)]
      head when head == ?ü -> [?u,?e | sanitize(tail)]
      head when head == ?ß -> [?s,?s | sanitize(tail)]
      _ -> sanitize(tail)
    end
  end
end
