# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ fn -> %{current_id: 1, plots: []} end) do
    Agent.start(opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1.plots)
  end

  defp add_plot(register_to) do
    fn state ->
        new = %Plot{plot_id: state.current_id + 1, registered_to: register_to}
        {new, %{current_id: state.current_id + 1, plots: [new | state.plots]}}
    end
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, add_plot(register_to))
  end

  defp remove_plot(plot_id) do
    &(%{current_id: &1.current_id, plots: Enum.filter(&1.plots, fn plot -> plot.plot_id !== plot_id end)})
  end

  def release(pid, plot_id) do
    Agent.update(pid, remove_plot(plot_id))
  end

  defp return_search([]), do: {:not_found, "plot is unregistered"}
  defp return_search([first | _]), do: first
  def get_registration(pid, plot_id) do
    Agent.get(pid, &(Enum.filter(&1.plots, fn plot -> plot.plot_id == plot_id end))) |> return_search()
  end
end
