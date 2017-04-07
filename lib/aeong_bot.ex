defmodule AeongBot do
  use Application
  @moduledoc """
  Documentation for AeongBot.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AeongBot.hello
      :world

  """
  def hello do
    :world  end

  def start(type, args) do
    config = %{
      twitter_stream: %{}
    }

    AeongSupervisor.start_link(config)
  end
end
