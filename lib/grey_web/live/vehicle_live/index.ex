defmodule GreyWeb.VehicleLive.Index do
  use GreyWeb, :live_view

  alias Grey.Vehicles
  alias Grey.Vehicles.Vehicle

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :vehicle_collection, list_vehicle())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Vehicle")
    |> assign(:vehicle, Vehicles.get_vehicle!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Vehicle")
    |> assign(:vehicle, %Vehicle{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Vehicle")
    |> assign(:vehicle, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    vehicle = Vehicles.get_vehicle!(id)
    {:ok, _} = Vehicles.delete_vehicle(vehicle)

    {:noreply, assign(socket, :vehicle_collection, list_vehicle())}
  end

  defp list_vehicle do
    Vehicles.list_vehicle()
  end
end
