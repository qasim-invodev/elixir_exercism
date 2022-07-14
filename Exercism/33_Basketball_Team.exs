#Access Behaviour

defmodule BasketballWebsite do
  defp do_extract(data, [path]), do: data[path]
  defp do_extract(data, [head | tail]), do: do_extract(data[head], tail)

  def extract_from_path(data, path) do
    split = path |> String.split(".", trim: true)
    do_extract(data, split)
  end

  defp do_get(data, path), do: get_in(data, path)
  def get_in_path(data, path) do
    split = path |> String.split(".", trim: true)
    do_get(data, split)
  end
end
