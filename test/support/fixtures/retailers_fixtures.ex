defmodule Grey.RetailersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Retailers` context.
  """

  @doc """
  Generate a retailer.
  """
  def retailer_fixture(attrs \\ %{}) do
    {:ok, retailer} =
      attrs
      |> Enum.into(%{
        description: "some description",
        location: "some location",
        name: "some name",
        status: "some status"
      })
      |> Grey.Retailers.create_retailer()

    retailer
  end
end
