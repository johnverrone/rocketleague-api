defmodule RocketleaguePhoenix.AuthErrorHandler do
 use RocketleaguePhoenix.Web, :controller

 def unauthenticated(conn, params) do
  conn
   |> put_status(401)
   |> render(RocketleaguePhoenix.ErrorView, "401.json")
 end

 def unauthorized(conn, params) do
  conn
   |> put_status(403)
   |> render(RocketleaguePhoenix.ErrorView, "403.json")
 end
end