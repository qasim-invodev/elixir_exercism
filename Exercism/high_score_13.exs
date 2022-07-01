# Exercise # 13 -  High Score - Maps, Module Attributes as Constants

defmodule HighScore do
  def new() do
    %{}
  end

  @constant 0
  def add_player(scores, name, score \\ @constant) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    Map.put(scores, name, @constant)
  end

  def update_score(scores, name, score) do
    cond do
      name in Map.keys(scores) -> Map.update!(scores, name, &(&1 + score))
      true -> add_player(scores, name, score)
    end
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end
