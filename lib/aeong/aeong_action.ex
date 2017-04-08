defmodule AeongBot.Aeong.AeongAction do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, [args], [{:name, __MODULE__}])
  end

  def init([config]) do
    state = %{
      celebrate_nth: config.celebrate_nth
    }

    {:ok, state}
  end

  def handle_call(_, _, state) do
    {:stop, {:error, :unknownmsg}, state}
  end

  def handle_cast(aeong, state) do
    if 0 == rem(aeong.count, state.celebrate_nth) do
      parent = Integer.to_string(aeong.parent)
      msg = Integer.to_string(aeong.count) <> "번째 애옹 " <> UUID.uuid4()
      tweet = "@" <> aeong.screen_name <> " " <> msg
      ExTwitter.update(tweet, [{:in_reply_to_status_id, parent}])
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
