defmodule Grey.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:device) do
      add :name, :string
      add :imei, :string
      add :description, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end
  end
end
