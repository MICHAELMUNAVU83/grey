defmodule Grey.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :rack_from, :string
      add :item, :string
      add :rack_to, :string
      add :status, :string
      add :user_id, :integer

      timestamps()
    end
  end
end
