defmodule RocketleaguePhoenix.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :game_number, :integer
      add :match_id, references(:matches, on_delete: :nothing)

      timestamps()
    end
    create index(:games, [:match_id])

  end
end
