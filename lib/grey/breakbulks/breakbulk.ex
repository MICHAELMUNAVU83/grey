defmodule Grey.Breakbulks.Breakbulk do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "breakbulks" do
    field :items, :string
    field :code, :string
    field :description, :string
    field :quantity, :string
    field :active, :boolean, default: false
    field :uom, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(breakbulk, attrs) do
    breakbulk
    |> cast(attrs, [:code, :active, :description, :quantity, :uom, :user_id, :items])
    |> validate_required([:code, :active, :quantity, :uom, :user_id, :items])
  end
end
