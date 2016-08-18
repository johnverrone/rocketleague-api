defmodule RocketleaguePhoenix.RegistrationControllerTest do
  use RocketleaguePhoenix.ConnCase

  alias RocketleaguePhoenix.User

  @valid_attrs %{
    "email" => "mike@example.com",
    "password" => "fqhi12hrrfasf",
    "password-confirmation" => "fqhi12hrrfasf"
  }
  
  @invalid_attrs %{}

 setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), data: %{attributes: @valid_attrs}
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, %{email: @valid_attrs["email"]})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    assert_error_sent 500, fn ->
      conn = post conn, registration_path(conn, :create), data: %{attributes: @invalid_attrs}
    end
  end

end