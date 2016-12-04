defmodule RocketleaguePhoenix.GamePlayerTest do
  use RocketleaguePhoenix.ModelCase

  alias RocketleaguePhoenix.GamePlayer

  @valid_attrs %{assists: 42, goals: 42, mvp: true, saves: 42, shots: 42, game_id: 1, player_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GamePlayer.changeset(%GamePlayer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GamePlayer.changeset(%GamePlayer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
