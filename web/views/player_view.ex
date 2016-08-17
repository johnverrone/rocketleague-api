defmodule RocketleaguePhoenix.PlayerView do
  use RocketleaguePhoenix.Web, :view
  use JaSerializer.PhoenixView

  attributes [:username, :first_name, :last_name, :email_address]
end
