defmodule AeongBot.Aeong.TwitterStream do
  use GenServer

  defmodule State do
    defstruct [:twitter]
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, [args], [])
  end

  def init(args) do
    state = %{
    }

    {:ok, state, 0}
  end

  def handle_call(_, _, state) do
    {:stop, {:error, :unknownmsg}, state}
  end

  def handle_cast(_, _, state) do
    {:stop, {:error, :unknownmsg}, state}
  end

  def handle_info(timeout, state) do
    # TODO: Fill this
    {:noreply, state, 0}
  end

  def terminate(reason, state) do
    :ok
  end

  def code_change(oldvsn, state, extr) do
    {:ok, state}
  end
end
