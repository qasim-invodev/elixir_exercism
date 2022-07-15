defmodule VariableLengthQuantity do
  use Bitwise
  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode([0x0]), do: <<0x0>>
  def encode(integers) do
    integers
    |> Enum.map(&do_encode(&1, 0, <<>>))
    |> Enum.reverse()
    |> Enum.reduce(<<>>, &<>/2)
  end
  defp do_encode(0, _, <<>>), do: <<0>>
  defp do_encode(0, _, acc), do: acc
  defp do_encode(n, b, acc) do
    n
    |> Bitwise.>>>(7)
    |> do_encode(1, <<b :: 1, n :: 7, acc :: binary>>)
  end
  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes), do: bytes |> do_decode(0, [])
  defp do_decode(<<>>, 0, []), do: {:error, "incomplete sequence"}
  defp do_decode(<<>>, 0, acc), do: {:ok, acc |> Enum.reverse()}
  defp do_decode(<<x :: 1, y :: 7, tail :: binary>>, n, acc) do
    shift = n
    |> Bitwise.<<<(7)
    |> Bitwise.|||(y)
     case x do
         0 -> do_decode(tail, 0,  [shift | acc])
         1 -> do_decode(tail, shift, acc)
       end
  end
  defp do_decode(_, _, _), do: {:error, "incomplete sequence"}
end
