defmodule RocketleaguePhoenix.TeamView do
  use RocketleaguePhoenix.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :wins, :loses]
  has_many :players, 
    serializer: RocketleaguePhoenix.PlayerView
  has_many :matches, 
    serializer: RocketleaguePhoenix.MatchView
end
