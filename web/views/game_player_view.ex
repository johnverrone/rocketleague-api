defmodule RocketleaguePhoenix.GamePlayerView do
  use RocketleaguePhoenix.Web, :view
  use JaSerializer.PhoenixView

  attributes [:game_id, :player_id, :goals, :assists, :saves, :shots, :score, :mvp]
end
