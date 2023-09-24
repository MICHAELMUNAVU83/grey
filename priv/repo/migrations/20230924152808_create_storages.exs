defmodule Grey.Repo.Migrations.CreateStorages do
  use Ecto.Migration

  def change do
    create table(:storages) do
      add :name, :string
      add :item, :string
      add :gln, :string
      add :description, :string
      add :active, :string
      add :user_id, :integer

      timestamps()
    end

    create index(:storages, [:user_id])
  end
end
