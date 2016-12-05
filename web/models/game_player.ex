defmodule RocketleaguePhoenix.GamePlayer do
  use RocketleaguePhoenix.Web, :model

  schema "game_players" do
    field :goals, :integer
    field :assists, :integer
    field :saves, :integer
    field :shots, :integer
    field :score, :float
    field :mvp, :boolean, default: false
    belongs_to :game, RocketleaguePhoenix.Game
    belongs_to :player, RocketleaguePhoenix.Player

    timestamps()
  end

  @required_fields ~w(goals assists saves shots score mvp game_id player_id)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:goals, :assists, :saves, :shots, :mvp])
  end
end
