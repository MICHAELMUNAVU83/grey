defmodule Grey.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string
      add :description, :string
      add :status, :string
      add :user_id, :integer

      timestamps()
    end
  end
end
