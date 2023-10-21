defmodule Grey.Repo.Migrations.CreateRetailers do
  use Ecto.Migration

  def change do
    create table(:retailers) do
      add :name, :string
      add :location, :string
      add :description, :string
      add :active, :boolean, default: false, null: false
      add :user_id, :integer

      timestamps()
    end

    create index(:retailers, [:user_id])
  end
end
