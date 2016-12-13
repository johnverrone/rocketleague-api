defmodule RocketleaguePhoenix.GameController do
  use RocketleaguePhoenix.Web, :controller

  alias RocketleaguePhoenix.Game

  def index(conn, _params) do
    games = Game |> Repo.all |> Repo.preload([:game_players])
    render(conn, "index.json-api", data: games)
  end

  def create(conn, %{"data" => data}) do
    changeset = Game.changeset(%Game{}, create_parms(data))

    case Repo.insert(changeset) do
      {:ok, game} ->
        game = Repo.preload(game, [:match])
        conn
        |> put_status(:created)
        |> put_resp_header("location", game_path(conn, :show, game))
        |> render("show.json-api", data: game)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RocketleaguePhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp create_parms(data) do
    data
      |> JaSerializer.Params.to_attributes
      |> Map.take(["match_id", "game_number"])
  end

  def show(conn, %{"id" => id}) do
    game = Repo.get!(Game, id) |> Repo.preload([:game_players])
    render(conn, "show.json-api", data: game)
  end

  def update(conn, %{"id" => id, "data" => data}) do
    game = Repo.get!(Game, id) |> Repo.preload([:game_players])
    changeset = Game.changeset(game, create_parms(data))

    case Repo.update(changeset) do
      {:ok, game} ->
        render(conn, "show.json-api", data: game)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RocketleaguePhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(game)

    send_resp(conn, :no_content, "")
  end
end
