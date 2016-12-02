defmodule RocketleaguePhoenix.GameTest do
  use RocketleaguePhoenix.ModelCase

  alias RocketleaguePhoenix.Game

  @valid_attrs %{game_number: 42, match_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Game.changeset(%Game{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Game.changeset(%Game{}, @invalid_attrs)
    refute changeset.valid?
  end
end
