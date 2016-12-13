defmodule RocketleaguePhoenix.GameControllerTest do
  use RocketleaguePhoenix.ConnCase

  alias RocketleaguePhoenix.Game
  @valid_attrs %{game_number: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, game_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    game = Repo.insert! %Game{}
    conn = get conn, game_path(conn, :show, game)
    assert json_response(conn, 200)["data"] == %{
      "id" => "#{game.id}", 
      "attributes" => %{
        "game-number" => nil, 
        "match-id" => nil
      }, 
      "type" => "game",
      "relationships" => %{"game-players" => %{"data" => []}}
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, game_path(conn, :show, -1)
    end
  end

  # test "creates and renders resource when data is valid", %{conn: conn} do
  #   conn = post conn, game_path(conn, :create), data: %{attributes: @valid_attrs }
  #   assert json_response(conn, 201)["data"]["id"]
  #   assert Repo.get_by(Game, @valid_attrs)
  # end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, game_path(conn, :create), data: %{attributes: @invalid_attrs }
    assert json_response(conn, 422)["errors"] != %{}
  end

  # test "updates and renders chosen resource when data is valid", %{conn: conn} do
  #   game = Repo.insert! %Game{}
  #   conn = put conn, game_path(conn, :update, game), data: %{attributes: @valid_attrs }
  #   assert json_response(conn, 200)["data"]["id"]
  #   assert Repo.get_by(Game, @valid_attrs)
  # end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    game = Repo.insert! %Game{}
    conn = put conn, game_path(conn, :update, game), data: %{attributes: @invalid_attrs }
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    game = Repo.insert! %Game{}
    conn = delete conn, game_path(conn, :delete, game)
    assert response(conn, 204)
    refute Repo.get(Game, game.id)
  end
end
