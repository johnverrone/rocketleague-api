defmodule RocketleaguePhoenix.Repo.Migrations.AddShotsColumn do
  use Ecto.Migration

  def change do
    alter table(:game_players) do
      add :score, :float
    end
  end
end
