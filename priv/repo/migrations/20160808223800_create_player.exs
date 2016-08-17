defmodule RocketleaguePhoenix.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :username, :string
      add :first_name, :string
      add :last_name, :string
      add :email_address, :string
      add :team_id, references(:teams)

      timestamps()
    end

  end
end
