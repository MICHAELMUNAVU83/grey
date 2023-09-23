defmodule Grey.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:device) do
      add :name, :string
      add :imei, :integer
      add :description, :string
      add :active, :boolean, default: false, null: false
      add :user_id, :integer

      timestamps()
    end
    create index(:device, [:user_id])

  end
end
