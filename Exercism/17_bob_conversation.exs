#Exercise -17 - Boolean and Cond

defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(sentence) do
    sentence = String.replace(sentence,~r/[- \n\r\t]/, "")
    cond do
          sentence == "" -> "Fine. Be that way!"
          String.last(sentence) == "?" and String.upcase(sentence) == sentence and sentence =~ ~r/[a-z]/i -> "Calm down, I know what I'm doing!"
          String.upcase(sentence) == sentence and sentence =~ ~r/[a-za-я]/i -> "Whoa, chill out!"
          String.last(sentence) == "?" -> "Sure."
          true -> "Whatever."
        end
  end
end
