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
      twitter_stream: %{
        filter_user: ~r/(IfElse__|perillamint)/,
        filter_keyword: ~r/애옹/
      },
      aeong_action: %{
        celebrate_nth: 1
      }
    }

    AeongSupervisor.start_link(config)
  end
end
