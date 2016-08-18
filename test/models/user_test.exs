defmodule RocketleaguePhoenix.UserTest do
  use RocketleaguePhoenix.ModelCase

  alias RocketleaguePhoenix.User

  @valid_attrs %{email: "test@login.com", password: "password", password_confirmation: "password"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "short password doesn't work" do
    changeset = User.changeset(%User{}, %{email: "example@test.com",
      password: "123",
      password_confirmation: "123"
    })
    refute changeset.valid?
  end

  test "mis-matched passwords don't work" do
    changeset = User.changeset(%User{}, %{email: "example@test.com",
      password: "testpassword",
      password_confirmation: "testmismatched"
    })
    refute changeset.valid?
  end
end
