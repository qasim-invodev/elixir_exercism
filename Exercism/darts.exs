#Exercise # 7: Darts Game : Cond Practice

defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
      x = elem({x,y},0)
      y = elem({x,y},1)
      sq_dist = (x*x)+(y*y)
      cond do
        sq_dist <= 1 -> 10
        sq_dist <= 5*5 -> 5
        sq_dist <= 10*10 -> 1
        true -> 0
      end
  end
end
