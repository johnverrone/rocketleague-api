defmodule RocketleaguePhoenix.MatchTest do
  use RocketleaguePhoenix.ModelCase

  alias RocketleaguePhoenix.Match

  @valid_attrs %{match_date: %{day: 17, month: 4, year: 2010}, blue_team_id: 3, orange_team_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Match.changeset(%Match{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Match.changeset(%Match{}, @invalid_attrs)
    refute changeset.valid?
  end
end
