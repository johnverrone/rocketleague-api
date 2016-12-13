defmodule RocketleaguePhoenix.Game do
  use RocketleaguePhoenix.Web, :model

  schema "games" do
    field :game_number, :integer
    belongs_to :match, RocketleaguePhoenix.Match
    has_many :game_players, RocketleaguePhoenix.GamePlayer

    timestamps()
  end

  @required_fields ~w(game_number match_id)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:match_id)
    |> validate_required([:game_number])
  end
end
