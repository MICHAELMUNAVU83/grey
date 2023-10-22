defmodule Grey.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :rack_from, :string
      add :item, :string
      add :rack_to, :string
      add :active, :boolean, default: false, null: false
      add :user_id, :integer

      timestamps()
    end

    create index(:transfers, [:user_id])
  end
end
