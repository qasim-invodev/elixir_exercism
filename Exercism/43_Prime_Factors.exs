defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1), do: []
  def factors_for(number) do
    fac = 2
    factors = []
    do_factors(number, fac, factors)
  end
  defp do_factors(1, _, factors), do: factors |> Enum.reverse()
  defp do_factors(number, fac, factors) do
    if rem(number,fac) != 0 do
      do_factors(number, fac + 1, factors)
    else
      new_factors = fac ++ factors
      new_num = div(number,fac)
      do_factors(new_num, fac, new_factors)
    end
  end
end

fac = factors_for(45) |> IO.inspect()
