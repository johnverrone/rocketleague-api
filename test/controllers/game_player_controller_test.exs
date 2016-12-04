defmodule RocketleaguePhoenix.GamePlayerControllerTest do
  use RocketleaguePhoenix.ConnCase

  alias RocketleaguePhoenix.GamePlayer
  @valid_attrs %{assists: 42, goals: 42, mvp: true, saves: 42, shots: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, game_player_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    game_player = Repo.insert! %GamePlayer{}
    conn = get conn, game_player_path(conn, :show, game_player)
    assert json_response(conn, 200)["data"] == %{
      "id" => "#{game_player.id}",
      "type" => "game-player",
      "attributes" => %{
        "game-id" => nil,
        "player-id" => nil,
        "goals" => game_player.goals,
        "assists" => game_player.assists,
        "saves" => game_player.saves,
        "shots" => game_player.shots,
        "mvp" => game_player.mvp
      }
    }
     
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, game_player_path(conn, :show, -1)
    end
  end

  # test "creates and renders resource when data is valid", %{conn: conn} do
  #   conn = post conn, game_player_path(conn, :create), game_player: @valid_attrs
  #   assert json_response(conn, 201)["data"]["id"]
  #   assert Repo.get_by(GamePlayer, @valid_attrs)
  # end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, game_player_path(conn, :create), data: %{attributes: @invalid_attrs}
    assert json_response(conn, 422)["errors"] != %{}
  end

  # test "updates and renders chosen resource when data is valid", %{conn: conn} do
  #   game_player = Repo.insert! %GamePlayer{}
  #   conn = put conn, game_player_path(conn, :update, game_player), game_player: @valid_attrs
  #   assert json_response(conn, 200)["data"]["id"]
  #   assert Repo.get_by(GamePlayer, @valid_attrs)
  # end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    game_player = Repo.insert! %GamePlayer{}
    conn = put conn, game_player_path(conn, :update, game_player), data: %{attributes: @invalid_attrs}
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    game_player = Repo.insert! %GamePlayer{}
    conn = delete conn, game_player_path(conn, :delete, game_player)
    assert response(conn, 204)
    refute Repo.get(GamePlayer, game_player.id)
  end
end
