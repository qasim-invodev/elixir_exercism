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
    do_factors(number, 2, [])
  end

  defp do_factors(number, fac, factors) when fac * fac > number , do: Enum.reverse([number | factors])
  defp do_factors(number, fac, factors) do
    if rem(number,fac) == 0 do
      do_factors(div(number,fac), fac, [fac | factors])
    else
      do_factors(number, fac + 1, factors)
    end
  end
end
