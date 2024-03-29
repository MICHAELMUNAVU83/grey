defmodule Grey.Suppliers.Supplier do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "suppliers" do
    field :description, :string
    field :name, :string
    field :active, :boolean, default: false
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(supplier, attrs) do
    supplier
    |> cast(attrs, [:name, :description, :active, :user_id])
    |> validate_required([:name, :description, :active, :user_id])
  end
end
