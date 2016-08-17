defmodule RocketleaguePhoenix.Repo.Migrations.AddUniqueIndexToPlayersEmail do
  use Ecto.Migration

  def change do
    create unique_index(:players, [:email_address])
  end
end
