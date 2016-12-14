defmodule RocketleaguePhoenix.TeamController do
  use RocketleaguePhoenix.Web, :controller

  alias RocketleaguePhoenix.Team

  def index(conn, _params) do
    teams = Team |> Repo.all |> Repo.preload([:players])
    render(conn, "index.json-api", data: teams)
  end

  def create(conn, %{"data" => %{"attributes" => team_params}}) do
    changeset = Team.changeset(%Team{}, team_params)

    case Repo.insert(changeset) do
      {:ok, team} ->
        team = Repo.preload(team, :players)
        conn
        |> put_status(:created)
        |> put_resp_header("location", team_path(conn, :show, team))
        |> render("show.json-api", data: team)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RocketleaguePhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Repo.get!(Team, id) |> Repo.preload(:players)
    render(conn, "show.json-api", data: team)
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => team_params}}) do
    team = Repo.get!(Team, id)
    changeset = Team.changeset(team, team_params)

    case Repo.update(changeset) do
      {:ok, team} ->
        team = Repo.preload(team, :players)
        render(conn, "show.json-api", data: team)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RocketleaguePhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(team)

    send_resp(conn, :no_content, "")
  end
end
