defmodule Grey.Repo.Migrations.CreatePutaways do
  use Ecto.Migration

  def change do
    create table(:putaways) do
      add :rack, :string
      add :item, :string
      add :status, :string
      add :user_id, :integer

      timestamps()
    end

    create index(:putaways, [:user_id])
  end
end
