defmodule RocketleaguePhoenix.SessionController do
  use RocketleaguePhoenix.Web, :controller

  def index(conn, _params) do
    # Return static json for now
    conn
    |> json(%{status: "Ok"})
  end
end