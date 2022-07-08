defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    earth = seconds/31557600
    cond do
      planet == :earth -> {:ok, Float.round(earth,2)}
      planet == :mercury -> {:ok, Float.round(earth/0.2408467,2)}
      planet == :venus -> {:ok, Float.round(earth/0.61519726,2)}
      planet == :mars -> {:ok, Float.round(earth/1.8808158,2)}
      planet == :jupiter -> {:ok, Float.round(earth/11.862615,2)}
      planet == :saturn -> {:ok, Float.round(earth/29.447498,2)}
      planet == :uranus -> {:ok, Float.round(earth/84.016846,2)}
      planet == :neptune -> {:ok, Float.round(earth/164.79132,2)}
      true -> {:error, "not a planet"}
    end
  end
end
