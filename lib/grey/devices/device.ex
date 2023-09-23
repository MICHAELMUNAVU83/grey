defmodule Grey.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users

  schema "device" do
    field :active, :boolean, default: false
    field :name, :string
    field :description, :string
    field :imei, :integer
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:name, :imei, :description, :active, :user_id])
    |> validate_required([:name, :imei, :description, :active, :user_id])
  end
end
