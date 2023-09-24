defmodule Grey.TransfersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Transfers` context.
  """

  @doc """
  Generate a transfer.
  """
  def transfer_fixture(attrs \\ %{}) do
    {:ok, transfer} =
      attrs
      |> Enum.into(%{
        item: "some item",
        rack_from: "some rack_from",
        rack_to: "some rack_to",
        status: "some status"
      })
      |> Grey.Transfers.create_transfer()

    transfer
  end
end
