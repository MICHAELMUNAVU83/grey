defmodule Grey.DevicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Devices` context.
  """

  @doc """
  Generate a device.
  """
  def device_fixture(attrs \\ %{}) do
    {:ok, device} =
      attrs
      |> Enum.into(%{
        active: true,
        name: "some name",
        description: "some description",
        imei: "some imei"
      })
      |> Grey.Devices.create_device()

    device
  end
end
