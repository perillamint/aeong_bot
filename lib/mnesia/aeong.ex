use Amnesia

defdatabase AeongBot.Mnesia.Aeong do
  deftable AeongCount, [:twitter_user_id, :screen_name, :count], type: :set do
    @type t :: %AeongCount{
      twitter_user_id: integer,
      screen_name: String.t,
      count: integer
    }
  end
end
