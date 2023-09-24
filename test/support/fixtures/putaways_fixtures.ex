defmodule Grey.PutawaysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Putaways` context.
  """

  @doc """
  Generate a putaway.
  """
  def putaway_fixture(attrs \\ %{}) do
    {:ok, putaway} =
      attrs
      |> Enum.into(%{
        item: "some item",
        rack: "some rack",
        status: "some status"
      })
      |> Grey.Putaways.create_putaway()

    putaway
  end
end
