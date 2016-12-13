defmodule RocketleaguePhoenix.GameView do
  use RocketleaguePhoenix.Web, :view
  use JaSerializer.PhoenixView

  attributes [:match_id, :game_number]
  has_many :game_players,
    serializer: RocketleaguePhoenix.GamePlayerView,
    include: true
end
