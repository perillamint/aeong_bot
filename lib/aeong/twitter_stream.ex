defmodule AeongBot.Aeong.TwitterStream do
  use GenServer
  alias ExTwitter.Model.Tweet, as: Tweet
  alias ExTwitter.Model.User, as: User

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

  def init([config]) do
    state = %{
      filter_user: :undefined,
      filter_keyword: :undefined
    }

    state = %{state | filter_user: config.filter_user}
    state = %{state | filter_keyword: config.filter_keyword}

    spawn_link(StreamListener, :start, [self()])

    {:ok, state}
  end

  def handle_call(_, _, state) do
    {:stop, {:error, :unknownmsg}, state}
  end

  def handle_cast(tweet, state) do
    handle_tweet(tweet, state)
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

  defp handle_tweet({:friends, friends}, state) do
    :ok
  end

  defp handle_tweet(twt = %Tweet{}, state) do
    %Tweet{
      text: htmltext,
      user: %User{
        screen_name: screen_name,
        id_str: user_id
      },
      id_str: tweet_id
    } = twt

    text = HtmlEntities.decode(htmltext);

    # Filter out users and keyworkds
    if Regex.match?(state.filter_user, screen_name) &&
      Regex.match?(state.filter_keyword, text) do
      IO.puts("Aeong")
    end
  end

  defp handle_tweet(_, state) do
    :ok
  end
end