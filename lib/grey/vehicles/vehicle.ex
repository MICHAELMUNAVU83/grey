defmodule Grey.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Staffs.Staff
  alias Grey.Users.User

  schema "vehicle" do
    field :active, :boolean, default: false
    field :serial, :string
    field :type, :string
    field :description, :string
    field :makeofcar, :string
    field :reg, :string
    belongs_to :staff, Staff, foreign_key: :staff_id
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:makeofcar, :type, :reg, :serial, :description, :active, :staff_id, :user_id])
    |> validate_required([
      :makeofcar,
      :type,
      :reg,
      :serial,
      :description,
      :active,
      :staff_id,
      :user_id
    ])
  end
end
