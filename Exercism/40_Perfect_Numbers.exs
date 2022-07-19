defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number > 0 do
    if number == 1 do
      {:ok, :deficient}
    else
      result = do_classify(number)
      cond do
        result > number -> {:ok, :abundant}
        result == number -> {:ok, :perfect}
        result < number -> {:ok, :deficient}
      end
    end
  end

  def classify(number) when number <= 0 do
    {:error, "Classification is only possible for natural numbers."}
  end

  defp do_classify(number) when number > 0 do
    Enum.filter(1..number-1, fn val -> rem(number,val) == 0 end)
    |> Enum.sum()
  end
end
