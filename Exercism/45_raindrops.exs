defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
  l = for n <- 1..number do
      if rem(number,n) == 0 do
        cond do
          n == 3 -> "Pling"
          n == 5 -> "Plang"
          n == 7 -> "Plong"
          true -> ""
        end
      else
        ""
      end
    end
    if String.length(Enum.join(l)) == 0 do
      to_string(number)
    else
      Enum.join(l)
    end
  end
end
