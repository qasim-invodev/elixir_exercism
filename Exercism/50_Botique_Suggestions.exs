defmodule BoutiqueSuggestions do

  def get_combinations(tops, bottoms, options \\ [maximum_price: 100.00]) do
    if options[:maximum_price] do
      for top <- tops,
          bottom <- bottoms,
          top.price + bottom.price <= options[:maximum_price] and top.base_color != bottom.base_color do
        {top, bottom}
      end
    else
      []
    end
  end
end
