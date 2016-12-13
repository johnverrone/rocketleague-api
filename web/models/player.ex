defmodule RocketleaguePhoenix.Player do
  use RocketleaguePhoenix.Web, :model

  schema "players" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :email_address, :string

    belongs_to :team, RocketleaguePhoenix.Team
    has_many :game_players, RocketleaguePhoenix.GamePlayer
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :first_name, :last_name, :email_address])
    |> validate_required([:username, :first_name, :last_name, :email_address])
    |> validate_format(:email_address, ~r/@/)
    |> unique_constraint(:email_address)
  end
end
