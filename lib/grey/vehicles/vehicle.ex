defmodule Grey.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vehicle" do
    field :active, :boolean, default: false
    field :serial, :string
    field :type, :string
    field :description, :string
    field :makeofcar, :string
    field :reg, :string

    timestamps()
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:makeofcar, :type, :reg, :serial, :description, :active])
    |> validate_required([:makeofcar, :type, :reg, :serial, :description, :active])
  end
end
