defmodule RocketleaguePhoenix.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :match_date, :date
      add :blue_team_id, references(:teams)
      add :orange_team_id, references(:teams)

      timestamps()
    end
  end
end
