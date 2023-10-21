defmodule Grey.Repo.Migrations.CreateReturns do
  use Ecto.Migration

  def change do
    create table(:returns) do
      add :item, :string
      add :quantity, :integer
      add :name, :string
      add :phone, :string
      add :reason, :string
      add :active, :boolean, default: false, null: false
      add :user_id, :integer

      timestamps()
    end

    create index(:returns, [:user_id])
  end
end
