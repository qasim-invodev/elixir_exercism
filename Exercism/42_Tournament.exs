defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    tally_performance(input)
    |> Enum.sort(fn {_t1,map1},{_t2,map2} -> map1.points >= map2.points end)
    |> display
  end

  """
  Function to calculate Team Score
  """
  @row %{played: 0, win: 0, draw: 0, loss: 0, points: 0}
  @inverse_result %{"win" => "loss", "loss" => "win", "draw" => "draw" }
  defp tally_performance(input) do
    input
    |> Enum.map(&String.split(&1,";"))
    |> Enum.filter(&(Enum.count(&1) == 3 && List.last(&1) in ["win","loss","draw"]))
    |> Enum.flat_map(fn [t1,t2,result] -> [[t1,result],[t2,@inverse_result[result]]] end)
    |> Enum.group_by(&List.first(&1), &List.last(&1)|>String.to_atom)
    |> Enum.map(fn {k,v} -> {k,Map.merge(@row,Enum.frequencies(v))} end)
    |> Enum.map(fn {k,v} -> {k,%{v | played: v.win+v.loss+v.draw, points: v.win*3+v.draw}}  end)
  end

  @header "Team                           | MP |  W |  D |  L |  P"
  defp display(data) do
    [@header]
    |> Enum.concat(Enum.map(data, fn {team,m} -> build_row({team,m})  end))
    |> Enum.join("\n")
  end

  defp build_row({team,m}) do
    "#{team}"
    |> String.pad_trailing(@header |> String.split("|") |> List.first|> String.length)
    |> List.wrap
    |> Enum.concat(Enum.map([:played, :win, :draw, :loss], fn x -> String.pad_leading("#{m[x]} ",4) end))
    |> Enum.concat([String.pad_leading("#{m.points}",3)])
    |> Enum.join("|")
  end
end
