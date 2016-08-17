defmodule RocketleaguePhoenix.MatchView do
  use RocketleaguePhoenix.Web, :view
  use JaSerializer.PhoenixView

  attributes [:match_date, :orange_team_id, :blue_team_id]
  has_one :blue_team,
    serializer: RocketleaguePhoenix.TeamView,
    include: true
  has_one :orange_team,
    serializer: RocketleaguePhoenix.TeamView,
    include: true
end
