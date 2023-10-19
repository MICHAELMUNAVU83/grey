defmodule GreyWeb.VehicleLive.Index do
  use GreyWeb, :admin_live_view

  alias Grey.Vehicles
  alias Grey.Vehicles.Vehicle
  alias Grey.Users
  alias Grey.Status

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:heading, "Vehicles")
     |> assign(:subheading, "This is a list of all your vehicles")
     |> assign(:vehicle_collection, list_vehicle())
     |> assign(:user, user)}
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

  @impl true
  def handle_event("change_status", %{"id" => id, "schema" => schema}, socket) do
    Status.change_status(id, schema)

    {:noreply, assign(socket, :vehicle_collection, list_vehicle())}
  end

  defp list_vehicle do
    Vehicles.list_vehicle()
  end
end
