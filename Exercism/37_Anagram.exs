defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    b = base |> String.downcase()
    Enum.filter(candidates, fn candidate ->
    c = String.downcase(candidate)
    c != b and check(c,b) end)
  end

  defp check(word, base) do
    base_letters = String.split(base, "") |> Enum.sort()
    candidate_letters = String.split(word, "") |> Enum.sort()
    base_letters == candidate_letters
  end
end
