defmodule Grey.Repo.Migrations.CreateVehicle do
  use Ecto.Migration

  def change do
    create table(:vehicle) do
      add :makeofcar, :string
      add :type, :string
      add :reg, :string
      add :serial, :string
      add :description, :string
      add :active, :boolean, default: false, null: false
      add :staff_id, :integer
      add :user_id, :integer

      timestamps()
    end
  end
end
