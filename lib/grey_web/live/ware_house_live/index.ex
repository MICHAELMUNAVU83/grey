defmodule GreyWeb.WareHouseLive.Index do
  use GreyWeb, :live_view

  alias Grey.WareHouses
  alias Grey.WareHouses.WareHouse
  alias Grey.Users

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:warehouse, list_warehouse())
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ware house")
    |> assign(:ware_house, WareHouses.get_ware_house!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ware house")
    |> assign(:ware_house, %WareHouse{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Warehouse")
    |> assign(:ware_house, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ware_house = WareHouses.get_ware_house!(id)
    {:ok, _} = WareHouses.delete_ware_house(ware_house)

    {:noreply, assign(socket, :warehouse, list_warehouse())}
  end

  defp list_warehouse do
    WareHouses.list_warehouse()
  end
end
