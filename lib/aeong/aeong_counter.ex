defmodule AeongBot.Aeong.AeongCounter do
  use GenServer
  use Amnesia

  def start_link(args) do
    GenServer.start_link(__MODULE__, [args], [{:name, __MODULE__}])
  end

  def init([config]) do
    {:ok, nil}
  end

  def handle_call(_, _, state) do
    {:stop, {:error, :unknownmsg}, state}
  end

  def handle_cast(aeong, state) do
    IO.inspect(aeong)

    Amnesia.transaction do
      #
    end

    {:noreply, state}
  end

  def handle_info(timeout, state) do
    {:noreply, state}
  end

  def terminate(reason, state) do
    :ok
  end

  def code_change(oldvsn, state, extr) do
    {:ok, state}
  end
end
