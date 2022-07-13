defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    back_work(list)
  end

  defp back_work([]) do
    []
  end

  defp back_work(list) when is_list(list) do
    [head | tail] = list
    cond do
      is_list(head) == true -> back_work(head) ++ back_work(tail)
      head == nil -> back_work(tail)
      true -> [head | back_work(tail)]
    end
  end
end
