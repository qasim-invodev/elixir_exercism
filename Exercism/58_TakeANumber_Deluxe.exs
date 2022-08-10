defmodule TakeANumberDeluxe do
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    min = Keyword.get(init_arg, :min_number, 0)
    max = Keyword.get(init_arg, :max_number, 0)
    auto_shutdown_timeout = Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)

    cond do
    (is_number(min) && is_number(max)) && (min < max) ->
        GenServer.start_link(__MODULE__, %TakeANumberDeluxe.State{
          min_number: min,
          max_number: max,
          queue: TakeANumberDeluxe.Queue.new(),
          auto_shutdown_timeout: auto_shutdown_timeout
        })

      true -> {:error, :invalid_configuration}
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    case priority_number do
      nil -> GenServer.call(machine, :serve_next_queued_number)
      _ -> GenServer.call(machine, {:serve_next_queued_number_with_priority, priority_number})
    end
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks
  @impl GenServer
  def init(init_arg) do
    {:ok, init_arg, init_arg.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    min = state.min_number
    max = state.max_number
    number =
      case TakeANumberDeluxe.Queue.empty?(state.queue) do
        true ->
          min
        false ->
          List.first(state.queue.in) + 1
      end
    case number > max do
      true ->
        {:reply, {:error, :all_possible_numbers_are_in_use}, state, state.auto_shutdown_timeout}
      false ->
        {:reply, {:ok, number},
         %{state | queue: TakeANumberDeluxe.Queue.push(state.queue, number)},
         state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call(:serve_next_queued_number, _from, state) do
    case TakeANumberDeluxe.Queue.out(state.queue) do
      {:empty, _} ->
        {:reply, {:error, :empty_queue}, state, state.auto_shutdown_timeout}
      {{:value, value}, q} ->
        {:reply, {:ok, value}, %{state | queue: q}, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number_with_priority, priority_number}, _from, state) do
    case TakeANumberDeluxe.Queue.member?(state.queue, priority_number) do
      false ->
        {:reply, {:error, :priority_number_not_found}, state, state.auto_shutdown_timeout}
      true ->
        {:reply, {:ok, priority_number},
         %{state | queue: TakeANumberDeluxe.Queue.delete(state.queue, priority_number)},
         state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    {:noreply,
     %TakeANumberDeluxe.State{
       min_number: state.min_number,
       max_number: state.max_number,
       queue: TakeANumberDeluxe.Queue.new(),
       auto_shutdown_timeout: state.auto_shutdown_timeout
     }, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
