defmodule Grey.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset

  schema "device" do
    field :active, :boolean, default: false
    field :name, :string
    field :description, :string
    field :imei, :string

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:name, :imei, :description, :active])
    |> validate_required([:name, :imei, :description, :active])
  end
end
