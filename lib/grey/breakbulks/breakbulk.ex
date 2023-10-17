defmodule Grey.Breakbulks.Breakbulk do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "breakbulks" do
    field :code, :string
    field :description, :string
    field :quantity, :string
    field :status, :boolean
    field :uom, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(breakbulk, attrs) do
    breakbulk
    |> cast(attrs, [:code, :status, :description, :quantity, :uom, :user_id])
    |> validate_required([:code, :status, :description, :quantity, :uom, :user_id])
  end
end
