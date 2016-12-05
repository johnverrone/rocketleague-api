defmodule RocketleaguePhoenix.MatchControllerTest do
  use RocketleaguePhoenix.ConnCase

  alias RocketleaguePhoenix.Match
  @valid_attrs %{match_date: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}
  @valid_relationships %{"orange_team" => %{"data" => %{type: "team", id: "1"}}, "blue_team" => %{"data" => %{type: "team", id: "1"}}}

  setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, match_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = get conn, match_path(conn, :show, match)
    assert json_response(conn, 200)["data"] == %{
      "id" => "#{match.id}",
      "type" => "match",
      "relationships" => %{
        "blue-team" => %{"data" => nil},
        "orange-team" => %{"data" => nil},
        "games" => %{"data" => []}
      },
      "attributes" => %{
        "blue-team-id" => match.blue_team_id,
        "orange-team-id" => match.orange_team_id,
        "match-date" => match.match_date,
        "week-number" => match.week_number
      },
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, match_path(conn, :show, -1)
    end
  end

  # test "creates and renders resource when data is valid", %{conn: conn} do
  #   conn = post conn, match_path(conn, :create), data: %{attributes: @valid_attrs, relationships: @valid_relationships}
  #   assert json_response(conn, 201)["data"]["id"]
  #   assert Repo.get_by(Match, @valid_attrs)
  # end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, match_path(conn, :create), data: %{attributes: @invalid_attrs}
    assert json_response(conn, 422)["errors"] != %{}
  end

  # test "updates and renders chosen resource when data is valid", %{conn: conn} do
  #   match = Repo.insert! %Match{}
  #   conn = put conn, match_path(conn, :update, match), data: %{attributes: @valid_attrs}
  #   assert json_response(conn, 200)["data"]["id"]
  #   assert Repo.get_by(Match, @valid_attrs)
  # end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = put conn, match_path(conn, :update, match), data: %{attributes: @invalid_attrs}
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = delete conn, match_path(conn, :delete, match)
    assert response(conn, 204)
    refute Repo.get(Match, match.id)
  end
end
