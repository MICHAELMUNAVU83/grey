defmodule Grey.Dispatches.Dispatch do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users

  schema "dispatches" do
    field :batch, :string
    field :companies, :string
    field :description, :string
    field :expiry, :string
    field :gtin, :string
    field :image, :string
    field :name, :string
    field :production, :string
    field :quantity, :string
    field :rack, :string
    field :status, :string
    field :transporter, :string
    field :transporterid, :string
    field :uom, :string
    field :weight, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(dispatch, attrs) do
    dispatch
    |> cast(attrs, [
      :name,
      :gtin,
      :quantity,
      :uom,
      :weight,
      :batch,
      :companies,
      :expiry,
      :production,
      :transporter,
      :transporterid,
      :description,
      :rack,
      :image,
      :status,
      :user_id
    ])
    |> validate_required([
      :name,
      :gtin,
      :quantity,
      :uom,
      :weight,
      :batch,
      :companies,
      :expiry,
      :production,
      :transporter,
      :transporterid,
      :description,
      :rack,
      :image,
      :status,
      :user_id
    ])
  end
end
