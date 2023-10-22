defmodule Grey.Receives.Receive do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "receives" do
    field :active, :string
    field :batch, :string
    field :description, :string
    field :expiry, :date
    field :gtin, :integer
    field :name, :string
    field :production, :date
    field :qty, :float
    field :uom, :string
    field :weight, :float
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(receive, attrs) do
    receive
    |> cast(attrs, [
      :name,
      :gtin,
      :qty,
      :uom,
      :weight,
      :batch,
      :description,
      :active,
      :production,
      :expiry,
      :user_id
    ])
    |> validate_required([
      :name,
      :gtin,
      :qty,
      :uom,
      :weight,
      :batch,
      :description,
      :active,
      :production,
      :expiry,
      :user_id
    ])
  end
end
