defmodule RocketleaguePhoenix.UserController do
  use RocketleaguePhoenix.Web, :controller

  alias RocketleaguePhoenix.User
  plug Guardian.Plug.EnsureAuthenticated, handler: RocketleaguePhoenix.AuthErrorHandler

  def current(conn, _) do
    user = conn
    |> Guardian.Plug.current_resource

    conn
    |> render(RocketleaguePhoenix.UserView, "show.json", user: user)
  end
end