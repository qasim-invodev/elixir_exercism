defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: RPG.LoafOfBread do
    def eat(_item, %RPG.Character{} = character) do
      {nil, %{character | health: character.health + 5}}
    end
  end

  defimpl Edible, for: RPG.Poison do
    def eat(_item, %RPG.Character{} = character) do
      {%RPG.EmptyBottle{}, %{character | health: 0}}
    end
  end

  defimpl Edible, for: RPG.ManaPotion do
    def eat(item, %RPG.Character{} = character) do
      {%RPG.EmptyBottle{}, %{character | mana: character.mana + item.strength}}
    end
  end
end
