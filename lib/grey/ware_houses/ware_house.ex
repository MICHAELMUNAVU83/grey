defmodule Grey.WareHouses.WareHouse do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "warehouse" do
    field :active, :boolean, default: false
    field :name, :string
    field :description, :string
    field :location, :string
    field :category, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(ware_house, attrs) do
    ware_house
    |> cast(attrs, [:name, :location, :category, :description, :active, :user_id])
    |> validate_required([:name, :location, :category, :description, :active, :user_id])
  end
end
