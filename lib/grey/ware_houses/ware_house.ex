defmodule Grey.WareHouses.WareHouse do
  use Ecto.Schema
  import Ecto.Changeset

  schema "warehouse" do
    field :active, :boolean, default: false
    field :name, :string
    field :description, :string
    field :location, :string
    field :category, :string

    timestamps()
  end

  @doc false
  def changeset(ware_house, attrs) do
    ware_house
    |> cast(attrs, [:name, :location, :category, :description, :active])
    |> validate_required([:name, :location, :category, :description, :active])
  end
end
