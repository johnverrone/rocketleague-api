defmodule RocketleaguePhoenix.TeamTest do
  use RocketleaguePhoenix.ModelCase

  alias RocketleaguePhoenix.Team

  @valid_attrs %{loses: 42, name: "some content", wins: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Team.changeset(%Team{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Team.changeset(%Team{}, @invalid_attrs)
    refute changeset.valid?
  end
end
