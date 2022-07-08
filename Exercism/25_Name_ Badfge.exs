defmodule NameBadge do
  def print(id, name, department) do
    if id do
      if department do
        "[#{id}] - #{name} - #{String.upcase(department)}"
      else
        "[#{id}] - #{name} - OWNER"
      end
    else
      if department do
        "#{name} - #{String.upcase(department)}"
      else
        "#{name} - OWNER"
      end
    end
  end
end
