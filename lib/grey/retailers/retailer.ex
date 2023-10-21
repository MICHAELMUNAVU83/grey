defmodule Grey.Retailers.Retailer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "retailers" do
    field :description, :string
    field :location, :string
    field :name, :string
    field :active, :boolean, default: false
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(retailer, attrs) do
    retailer
    |> cast(attrs, [:name, :location, :description, :active, :user_id])
    |> validate_required([:name, :location, :description, :active, :user_id])
  end
end
