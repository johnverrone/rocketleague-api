defmodule RocketleaguePhoenix.GameView do
  use RocketleaguePhoenix.Web, :view
  use JaSerializer.PhoenixView

  attributes [:match_id, :game_number]
end
