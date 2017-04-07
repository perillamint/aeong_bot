defmodule AeongBot.Aeong.TwitterStream do
  use GenServer

  defmodule State do
    defstruct [:twitter]
  end

  defmodule StreamListener do
    def start(parent) do
      ExTwitter.stream_user()
      |> Enum.take_while(fn (data) ->
        GenServer.cast(parent, data)
      end)
    end
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, [args], [])
  end

  def init(args) do
    state = %{
      extwitter: :undefined
    }

    spawn_link(StreamListener, :start, [self()])

    {:ok, state}
  end

  def handle_call(_, _, state) do
    {:stop, {:error, :unknownmsg}, state}
  end

  def handle_cast(msg, state) do
    IO.inspect(msg)
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
