defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []

  def matrix(dimension) do
    do_matrix(dimension, dimension, 1)
  end

  defp do_matrix(_row, 0, _start), do: [[]]
  defp do_matrix(row, col, start) do
    [
      start..(start + col - 1) |> Enum.to_list() |
      do_matrix(col, row - 1, start + col) |> rotate_right
    ]
  end

  defp rotate_right(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.reverse/1)
  end
end
