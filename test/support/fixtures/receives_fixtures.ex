defmodule Grey.ReceivesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Receives` context.
  """

  @doc """
  Generate a receive.
  """
  def receive_fixture(attrs \\ %{}) do
    {:ok, receive} =
      attrs
      |> Enum.into(%{
        active: "some active",
        batch: "some batch",
        description: "some description",
        expiry: ~D[2023-10-21],
        gtin: 42,
        name: "some name",
        production: ~D[2023-10-21],
        qty: 120.5,
        uom: "some uom",
        weight: 120.5
      })
      |> Grey.Receives.create_receive()

    receive
  end
end
