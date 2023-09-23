defmodule Grey.WareHousesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.WareHouses` context.
  """

  @doc """
  Generate a ware_house.
  """
  def ware_house_fixture(attrs \\ %{}) do
    {:ok, ware_house} =
      attrs
      |> Enum.into(%{
        active: true,
        name: "some name",
        description: "some description",
        location: "some location",
        category: "some category"
      })
      |> Grey.WareHouses.create_ware_house()

    ware_house
  end
end
