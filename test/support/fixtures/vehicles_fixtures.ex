defmodule Grey.VehiclesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Vehicles` context.
  """

  @doc """
  Generate a vehicle.
  """
  def vehicle_fixture(attrs \\ %{}) do
    {:ok, vehicle} =
      attrs
      |> Enum.into(%{
        active: true,
        serial: "some serial",
        type: "some type",
        description: "some description",
        makeofcar: "some makeofcar",
        reg: "some reg"
      })
      |> Grey.Vehicles.create_vehicle()

    vehicle
  end
end
