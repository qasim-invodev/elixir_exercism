defmodule Chessboard do
  def rank_range do
    1..8
  end

  def file_range do
    65..72
  end

  def ranks do
    Enum.to_list(rank_range())
  end

  def files do
    Enum.map(file_range(), fn file -> <<file>> end)
  end
end
