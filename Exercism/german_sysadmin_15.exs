# Exercise - 15 - German Sysadmin - case , charlist


defmodule Username do
  def sanitize([]), do: []
  def sanitize([head | tail]) do
    case head do
      head when head >= 97 and head <= 122 -> [head] ++ sanitize(tail)
      head when head == 95 -> [head] ++ sanitize(tail)
      head when head == 228 -> [97,101] ++ sanitize(tail)
      head when head == 246 -> [111,101] ++ sanitize(tail)
      head when head == 252 -> [117,101] ++ sanitize(tail)
      head when head == 223 -> [115,115] ++ sanitize(tail)
      _ -> sanitize(tail)
    end
  end
end
