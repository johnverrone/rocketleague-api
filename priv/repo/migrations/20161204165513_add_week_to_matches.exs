defmodule RocketleaguePhoenix.Repo.Migrations.AddWeekToMatches do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :week_number, :integer
    end
  end
end
