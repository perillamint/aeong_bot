defmodule AeongSupervisor do
  use Supervisor
  alias AeongBot.Aeong.TwitterStream, as: TwitterStream
  alias AeongBot.Aeong.AeongCounter, as: AeongCounter
  alias AeongBot.Aeong.AeongAction, as: AeongAction

  def start_link(param) do
    Supervisor.start_link(__MODULE__, param, [{:name, __MODULE__}])
  end

  def init(args) do
    childs = [worker(TwitterStream, [args.twitter_stream], []),
              worker(AeongCounter, [nil], []),
              worker(AeongAction, [args.aeong_action], [])]

    supervise(childs, [
          {:strategy, :one_for_one},
          {:max_restarts, 10},
          {:max_seconds, 5}
        ])
    end
end
