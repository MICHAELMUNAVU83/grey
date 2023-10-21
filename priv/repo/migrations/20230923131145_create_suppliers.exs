defmodule Grey.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string
      add :description, :string
      add :active, :boolean, default: false, null: false
      add :user_id, :integer

      timestamps()
    end

    create index(:suppliers, [:user_id])
  end
end
