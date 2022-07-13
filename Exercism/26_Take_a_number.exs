defmodule TakeANumber do
  @moduledoc """
  Embedded system for a Take-A-Number machine that gives out consecutive numbers and reports what was the last number given out.
  """
  @doc """
  Spawns a new process that has an initial state of 0 and is ready to receive messages.

  ## Examples:

      iex> is_pid(TakeANumber.start())
      true

  """
  @spec start() :: pid()
  def start() do
    spawn(fn -> message_loop(0) end)
  end

  defp message_loop(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid,state)
        message_loop(state)

      {:take_a_number, sender_pid} ->
        send(sender_pid,state + 1)
        message_loop(state + 1)

      :stop -> :ok

      _ -> message_loop(state)
    end
  end
end
