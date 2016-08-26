defmodule RocketleaguePhoenix.RegistrationController do
  use RocketleaguePhoenix.Web, :controller

  alias RocketleaguePhoenix.User

  def create(conn, %{"data" => %{"attributes" => user_attrs}}) do
    
    changeset = User.changeset(%User{}, user_attrs)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render(RocketleaguePhoenix.UserView, "show.json", data: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RocketleaguePhoenix.ChangesetView, "error.json", changeset: changeset)
    end  
  end
end