defmodule ResistorColorTrio do
  @resistor_map %{black: 0, brown: 1, red: 2, orange: 3, yellow: 4, green: 5, blue: 6, violet: 7, grey: 8, white: 9}
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    [color1 | tail] = colors
    [color2 | tl] = tail
    [color3 | _t] = tl
    val1 = Map.get(@resistor_map, color1)
    val2 = Map.get(@resistor_map, color2)
    val3 = Map.get(@resistor_map, color3)
    result = (String.to_integer("#{val1}#{val2}") * Integer.pow(10,val3))
    if result >= 1000 do
      {result/1000, :kiloohms}
    else
      {result, :ohms}
    end
  end
end
