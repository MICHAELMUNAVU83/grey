defmodule Grey.Putaways.Putaway do
  use Ecto.Schema
  import Ecto.Changeset
  alias Grey.Users.User

  schema "putaways" do
    field :item, :string
    field :rack, :string
    field :active, :boolean, default: false
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(putaway, attrs) do
    putaway
    |> cast(attrs, [:rack, :item, :active, :user_id])
    |> validate_required([:rack, :item, :active, :user_id])
  end
end
