# Exercise # 10 - Kitchen Calculator - Pattern Matching - Tuples


defmodule KitchenCalculator do
  def get_volume(volume_pair) when is_tuple(volume_pair) do
    elem(volume_pair,1)
  end

  def to_milliliter({:cup,vol} = _volume_pair) do
    {:milliliter,vol * 240}
  end
  def to_milliliter({:fluid_ounce,vol} = _volume_pair) do
    {:milliliter,vol * 30}
  end
  def to_milliliter({:teaspoon,vol} = _volume_pair) do
    {:milliliter,vol * 5}
  end
  def to_milliliter({:tablespoon,vol} = _volume_pair) do
    {:milliliter,vol * 15}
  end
  def to_milliliter({:milliliter,vol} = _volume_pair) do
    {:milliliter,vol * 1}
  end


  def from_milliliter({:milliliter,vol} = _volume_pair, :teaspoon = unit) do
    {unit,vol / 5}
  end
  def from_milliliter({:milliliter,vol} = _volume_pair, :tablespoon = unit) do
    {unit,vol / 15}
  end
  def from_milliliter({:milliliter,vol} = _volume_pair, :milliliter = unit) do
    {unit,vol / 1}
  end
  def from_milliliter({:milliliter,vol} = _volume_pair, :cup = unit) do
    {unit,vol / 240}
  end
  def from_milliliter({:milliliter,vol} = _volume_pair, :fluid_ounce = unit) do
    {unit,vol / 30}
  end

  def convert(volume_pair, unit) do
    from_milliliter(to_milliliter(volume_pair),unit)
  end
end
