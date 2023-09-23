defmodule Grey.Repo.Migrations.CreateReturns do
  use Ecto.Migration

  def change do
    create table(:returns) do
      add :item, :string
      add :quantity, :integer
      add :name, :string
      add :phone, :string
      add :reason, :string
      add :status, :string
      add :user_id, :integer

      timestamps()
    end
  end
end
