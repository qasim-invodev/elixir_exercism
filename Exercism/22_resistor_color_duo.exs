defmodule ResistorColorDuo do
  @resistor_map %{black: 0, brown: 1, red: 2, orange: 3, yellow: 4, green: 5, blue: 6, violet: 7, grey: 8, white: 9}
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    [color1 | tail] = colors
    [color2 | _tl] = tail
    val1 = Map.get(@resistor_map, color1)
    val2 = Map.get(@resistor_map, color2)
    String.to_integer("#{val1}#{val2}")
  end
end
