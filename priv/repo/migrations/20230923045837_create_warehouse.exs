defmodule Grey.Repo.Migrations.CreateWarehouse do
  use Ecto.Migration

  def change do
    create table(:warehouse) do
      add :name, :string
      add :location, :string
      add :category, :string
      add :description, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end
  end
end
