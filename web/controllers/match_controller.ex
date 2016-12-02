defmodule RocketleaguePhoenix.MatchController do
  use RocketleaguePhoenix.Web, :controller

  alias RocketleaguePhoenix.Match

  def index(conn, _params) do
    matches = Match |> Repo.all |> Repo.preload([:blue_team, :orange_team, :games]) |> Repo.preload([blue_team: :players, orange_team: :players])
    render(conn, "index.json-api", data: matches)
  end

  def create(conn, %{"data" => data}) do
    changeset = Match.changeset(%Match{}, create_parms(data))

    case Repo.insert(changeset) do
      {:ok, match} ->
        match = Repo.preload(match, [:blue_team, :orange_team, :games]) |> Repo.preload([blue_team: :players, orange_team: :players])
        conn
        |> put_status(:created)
        |> put_resp_header("location", match_path(conn, :show, match))
        |> render("show.json-api", data: match)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RocketleaguePhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp create_parms(data) do
    data
      |> JaSerializer.Params.to_attributes
      |> Map.take(["match_date", "blue_team_id", "orange_team_id"])
  end

  def show(conn, %{"id" => id}) do
    match = Repo.get!(Match, id) |> Repo.preload([:blue_team, :orange_team, :games]) |> Repo.preload([blue_team: :players, orange_team: :players])
    render(conn, "show.json-api", data: match)
  end

  def update(conn, %{"id" => id, "data" => data}) do
    match = Repo.get!(Match, id) |> Repo.preload([:blue_team, :orange_team, :games])
    changeset = Match.changeset(match, create_parms(data))

    case Repo.update(changeset) do
      {:ok, match} ->
        render(conn, "show.json-api", data: match)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RocketleaguePhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Repo.get!(Match, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(match)

    send_resp(conn, :no_content, "")
  end
end
