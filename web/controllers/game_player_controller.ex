defmodule RocketleaguePhoenix.GamePlayerController do
  use RocketleaguePhoenix.Web, :controller

  alias RocketleaguePhoenix.GamePlayer

  def index(conn, _params) do
    game_players = Repo.all(GamePlayer) |> Repo.preload([:player])
    render(conn, "index.json-api", data: game_players)
  end

  def create(conn, %{"data" => data}) do
    changeset = GamePlayer.changeset(%GamePlayer{}, create_parms(data))

    case Repo.insert(changeset) do
      {:ok, game_player} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", game_player_path(conn, :show, game_player))
        |> render("show.json-api", data: game_player)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RocketleaguePhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp create_parms(data) do
    data
      |> JaSerializer.Params.to_attributes
      |> Map.take(["game_id", "player_id", "goals", "assists", "shots", "saves", "score", "mvp"])
  end

  def show(conn, %{"id" => id}) do
    game_player = Repo.get!(GamePlayer, id) |> Repo.preload([:player])
    render(conn, "show.json-api", data: game_player)
  end

  def update(conn, %{"id" => id, "data" => data}) do
    game_player = Repo.get!(GamePlayer, id) |> Repo.preload([:player])
    changeset = GamePlayer.changeset(game_player, create_parms(data))

    case Repo.update(changeset) do
      {:ok, game_player} ->
        render(conn, "show.json-api", game_player: game_player)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RocketleaguePhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game_player = Repo.get!(GamePlayer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(game_player)

    send_resp(conn, :no_content, "")
  end
end
