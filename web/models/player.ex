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

  @required_fields ~w(username first_name last_name email_address team_id)
  @optional_fields ~w()


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:team_id)
    |> validate_format(:email_address, ~r/@/)
    |> unique_constraint(:email_address)
  end
end
