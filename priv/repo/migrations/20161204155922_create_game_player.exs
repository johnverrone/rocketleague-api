defmodule RocketleaguePhoenix.Repo.Migrations.CreateGamePlayer do
  use Ecto.Migration

  def change do
    create table(:game_players) do
      add :goals, :integer
      add :assists, :integer
      add :saves, :integer
      add :shots, :integer
      add :mvp, :boolean, default: false, null: false
      add :game_id, references(:games, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)

      timestamps()
    end
    create index(:game_players, [:game_id])
    create index(:game_players, [:player_id])

  end
end
