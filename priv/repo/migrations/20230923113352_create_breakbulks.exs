defmodule Grey.Repo.Migrations.CreateBreakbulks do
  use Ecto.Migration

  def change do
    create table(:breakbulks) do
      add :code, :string
      add :status, :string
      add :description, :string
      add :quantity, :string
      add :uom, :string
      add :user_id, :integer

      timestamps()
    end
    create index(:breakbulks, [:user_id])

  end
end
