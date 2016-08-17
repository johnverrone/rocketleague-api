defmodule RocketleaguePhoenix.Team do
  use RocketleaguePhoenix.Web, :model

  schema "teams" do
    field :name, :string
    field :wins, :integer
    field :loses, :integer

    has_many :players, RocketleaguePhoenix.Player
    has_many :blue_matches, RocketleaguePhoenix.Match, foreign_key: :blue_team_id
    has_many :orange_matches, RocketleaguePhoenix.Match, foreign_key: :orange_team_id
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :wins, :loses])
    |> validate_required([:name, :wins, :loses])
  end
end
