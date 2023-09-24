defmodule Grey.StoragesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Storages` context.
  """

  @doc """
  Generate a storage.
  """
  def storage_fixture(attrs \\ %{}) do
    {:ok, storage} =
      attrs
      |> Enum.into(%{
        active: "some active",
        name: "some name",
        description: "some description",
        item: "some item",
        gln: "some gln"
      })
      |> Grey.Storages.create_storage()

    storage
  end
end
