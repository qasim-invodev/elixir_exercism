defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> handshake(Bitwise.band(code, 8) > 0, "jump")
    |> handshake(Bitwise.band(code, 4) > 0, "close your eyes")
    |> handshake(Bitwise.band(code, 2) > 0, "double blink")
    |> handshake(Bitwise.band(code, 1) > 0, "wink")
    |> reverse(Bitwise.band(code, 16) > 0)
  end

  defp handshake(actions, true, action), do: [action|actions]
  defp handshake(actions, _, _), do: actions

  defp reverse(actions, true), do: Enum.reverse(actions)
  defp reverse(actions, _), do: actions
end
