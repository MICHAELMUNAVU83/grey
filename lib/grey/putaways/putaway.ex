defmodule Grey.Putaways.Putaway do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "putaways" do
    field :item, :string
    field :rack, :string
    field :status, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(putaway, attrs) do
    putaway
    |> cast(attrs, [:rack, :item, :status, :user_id])
    |> validate_required([:rack, :item, :status, :user_id])
  end
end
