defmodule Grey.Repo.Migrations.CreateRetailers do
  use Ecto.Migration

  def change do
    create table(:retailers) do
      add :name, :string
      add :location, :string
      add :description, :string
      add :status, :string
      add :user_id, :integer

      timestamps()
    end
    create index(:retailers, [:user_id])

  end
end
