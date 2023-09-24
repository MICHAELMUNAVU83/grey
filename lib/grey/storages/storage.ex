defmodule Grey.Storages.Storage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "storages" do
    field :active, :string
    field :name, :string
    field :description, :string
    field :item, :string
    field :gln, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(storage, attrs) do
    storage
    |> cast(attrs, [:name, :item, :gln, :description, :active, :user_id])
    |> validate_required([:name, :item, :gln, :description, :active, :user_id])
  end
end
