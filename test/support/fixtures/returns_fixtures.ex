defmodule Grey.ReturnsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Returns` context.
  """

  @doc """
  Generate a return.
  """
  def return_fixture(attrs \\ %{}) do
    {:ok, return} =
      attrs
      |> Enum.into(%{
        item: "some item",
        name: "some name",
        phone: "some phone",
        quantity: "some quantity",
        reason: "some reason",
        status: "some status"
      })
      |> Grey.Returns.create_return()

    return
  end
end
