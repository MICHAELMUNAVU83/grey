defmodule Grey.Repo.Migrations.AddIndexToBreakbulk do
  use Ecto.Migration

  def change do
    alter table(:breakbulks) do
      modify(:code, :string, index: true)
    end
  end
end
