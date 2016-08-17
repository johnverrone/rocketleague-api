defmodule RocketleaguePhoenix.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :wins, :integer
      add :loses, :integer

      timestamps()
    end

  end
end
