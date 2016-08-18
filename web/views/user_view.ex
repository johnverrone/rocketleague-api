defmodule RocketleaguePhoenix.UserView do
  use RocketleaguePhoenix.Web, :view
  use JaSerializer.PhoenixView

  attributes [:email]
end