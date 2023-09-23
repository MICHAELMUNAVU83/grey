defmodule Grey.DispatchesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Dispatches` context.
  """

  @doc """
  Generate a dispatch.
  """
  def dispatch_fixture(attrs \\ %{}) do
    {:ok, dispatch} =
      attrs
      |> Enum.into(%{
        batch: "some batch",
        companies: "some companies",
        description: "some description",
        expiry: "some expiry",
        gtin: "some gtin",
        image: "some image",
        name: "some name",
        production: "some production",
        quantity: "some quantity",
        rack: "some rack",
        status: "some status",
        transporter: "some transporter",
        transporterid: "some transporterid",
        uom: "some uom",
        weight: "some weight"
      })
      |> Grey.Dispatches.create_dispatch()

    dispatch
  end
end
