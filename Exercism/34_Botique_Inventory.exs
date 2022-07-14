defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory |> Enum.sort_by(&(&1.price))
  end

  def with_missing_price(inventory) do
    inventory |> Enum.filter(fn x -> x[:price] == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    change_word = fn name -> String.replace(name, old_word, new_word) end
    change_name = fn item -> Map.update!(item, :name, change_word) end
    Enum.map(inventory, change_name)
  end

  def increase_quantity(item, count) do
    new = Enum.into(item.quantity_by_size, %{}, fn {size, c} -> {size, c+count} end)
    %{item | quantity_by_size: new}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_k,v},acc -> v+acc end)
  end
end
