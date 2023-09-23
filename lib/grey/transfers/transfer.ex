defmodule Grey.Transfers.Transfer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "transfers" do
    field :item, :string
    field :rack_from, :string
    field :rack_to, :string
    field :status, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:rack_from, :item, :rack_to, :status, :user_id])
    |> validate_required([:rack_from, :item, :rack_to, :status, :user_id])
  end
end
