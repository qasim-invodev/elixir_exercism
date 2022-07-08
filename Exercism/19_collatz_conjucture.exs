defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(1) do
    0
  end
  def calc(input) when is_integer(input) and input > 1 do
    step = if rem(input,2) == 0 do
      input = div(input,2)
      calc(input) + 1
    else
      input = (input * 3) + 1
      calc(input) + 1
    end
    step
  end
end
