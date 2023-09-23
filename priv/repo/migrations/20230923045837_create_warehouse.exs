defmodule Grey.Repo.Migrations.CreateWarehouse do
  use Ecto.Migration

  def change do
    create table(:warehouse) do
      add :name, :string
      add :location, :string
      add :category, :string
      add :description, :string
      add :active, :boolean, default: false, null: add(:user_id, :integer)

      timestamps()
    end

    create index(:warehouse, [:user_id])
  end
end
