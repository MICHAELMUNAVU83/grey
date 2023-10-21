defmodule Grey.Staffs.Staff do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Vehicles.Vehicle
  alias Grey.Users.User

  schema "staff" do
    field :active, :boolean, default: false
    field :serial, :string
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    field :phone, :string
    field :passcode, :string
    field :nationalid, :string
    field :dob, :date
    field :description, :string
    has_many :vehicles, Vehicle
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(staff, attrs) do
    staff
    |> cast(attrs, [
      :firstname,
      :lastname,
      :email,
      :phone,
      :passcode,
      :serial,
      :nationalid,
      :dob,
      :active,
      :description,
      :user_id
    ])
    |> validate_required([
      :firstname,
      :lastname,
      :email,
      :phone,
      :passcode,
      :serial,
      :nationalid,
      :dob,
      :active,
      :description,
      :user_id
    ])
  end
end
