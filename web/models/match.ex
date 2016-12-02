defmodule RocketleaguePhoenix.Match do
  use RocketleaguePhoenix.Web, :model

  alias RocketleaguePhoenix.Team
  alias RocketleaguePhoenix.Game

  schema "matches" do
    field :match_date, Ecto.Date
    belongs_to :blue_team, Team
    belongs_to :orange_team, Team
    has_many :games, Game

    timestamps()
  end

  @required_fields ~w(match_date blue_team_id orange_team_id)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:blue_team_id)
    |> foreign_key_constraint(:orange_team_id)
    |> validate_required([:match_date])
  end
end
