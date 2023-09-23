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

      timestamps()
    end
  end
end
