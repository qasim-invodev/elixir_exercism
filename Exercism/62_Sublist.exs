defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      length(b) == length(a) -> do_compare(a,b)
      true -> do_compare(a, b, 0)
    end
  end

  defp do_compare([], []), do: :equal
  defp do_compare([h1 | t1]= _a, [h2 | t2] = _b) do
    if h1 == h2 do
      do_compare(t1, t2)
    else
      :unequal
    end
  end

  defp do_compare([], _b, _), do: :sublist
  defp do_compare(a, b, pos) when length(a) < length(b) and pos + length(a) > length(b), do: :unequal
  defp do_compare(a, b, pos) when length(a) < length(b) and pos + length(a) <= length(b) do
    if Enum.slice(b,pos,length(a)) === a do
      :sublist
    else
      do_compare(a, b, pos + 1)
    end
  end

  defp do_compare(_a, [], _), do: :superlist
  defp do_compare(a, b, pos) when length(a) > length(b) and pos + length(b) > length(a), do: :unequal
  defp do_compare(a, b, pos) when length(a) > length(b) and pos + length(b) <= length(a) do
    if Enum.slice(a,pos,length(b)) === b do
      :superlist
    else
      do_compare(a, b, pos + 1)
    end
  end
end
