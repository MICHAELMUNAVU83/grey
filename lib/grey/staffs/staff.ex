defmodule Grey.Staffs.Staff do
  use Ecto.Schema
  import Ecto.Changeset

  schema "staff" do
    field :active, :boolean, default: false
    field :serial, :string
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    field :phone, :string
    field :passcode, :string
    field :nationalid, :string
    field :dob, :string
    field :decsription, :string

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
      :decsription
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
      :decsription
    ])
  end
end
