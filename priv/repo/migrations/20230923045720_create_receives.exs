defmodule Grey.Repo.Migrations.CreateReceives do
  use Ecto.Migration

  def change do
    create table(:receives) do
      add :name, :string
      add :gtin, :integer
      add :qty, :float
      add :uom, :string
      add :weight, :float
      add :batch, :string
      add :description, :string
      add :active, :string
      add :production, :date
      add :expiry, :date
      add :user_id, :integer

      timestamps()
    end

    create index(:receives, [:user_id])
  end
end
