defmodule Grey.Repo.Migrations.CreateDispatches do
  use Ecto.Migration

  def change do
    create table(:dispatches) do
      add :name, :string
      add :gtin, :string
      add :quantity, :string
      add :uom, :string
      add :weight, :string
      add :batch, :string
      add :companies, :string
      add :expiry, :string
      add :production, :string
      add :transporter, :string
      add :transporterid, :string
      add :description, :string
      add :rack, :string
      add :image, :string
      add :status, :string
      add :user_id, :integer

      timestamps()
    end
    create index(:dispatches, [:user_id])

  end
end
