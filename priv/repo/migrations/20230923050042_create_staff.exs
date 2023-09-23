defmodule Grey.Repo.Migrations.CreateStaff do
  use Ecto.Migration

  def change do
    create table(:staff) do
      add :firstname, :string
      add :lastname, :string
      add :email, :string
      add :phone, :string
      add :passcode, :string
      add :serial, :string
      add :nationalid, :string
      add :dob, :string
      add :active, :boolean, default: false, null: false
      add :decsription, :string
      add :user_id, :integer

      timestamps()
    end

    create index(:staff, [:user_id])
  end
end
