defmodule Grey.Returns.Return do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "returns" do
    field :item, :string
    field :name, :string
    field :phone, :string
    field :quantity, :integer
    field :reason, :string
    field :status, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(return, attrs) do
    return
    |> cast(attrs, [:item, :quantity, :name, :phone, :reason, :status, :user_id])
    |> validate_required([:item, :quantity, :name, :phone, :reason, :status, :user_id])
  end
end
