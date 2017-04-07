defmodule AeongBot.Aeong.AeongCounter do
  use GenServer
  use Amnesia
  alias AeongBot.Mnesia.Aeong.AeongCount, as: AeongCount
  alias AeongBot.Aeong.AeongAction, as: AeongAction

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
    aeong = Amnesia.transaction do
      aeong = case AeongCount.read(aeong.user_id) do
                nil ->
                  %AeongCount{
                    twitter_user_id: aeong.user_id,
                    screen_name: aeong.screen_name,
                    count: 0
                  }
                aeong_count ->
                  aeong_count
              end

      aeong = %{aeong | count: aeong.count + 1}

      AeongCount.write(aeong)
    end

    GenServer.cast(AeongAction, aeong)

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
