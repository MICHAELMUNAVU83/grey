defmodule GreyWeb.WareHouseLive.Show do
  use GreyWeb, :live_view

  alias Grey.WareHouses

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ware_house, WareHouses.get_ware_house!(id))}
  end

  defp page_title(:show), do: "Show Ware house"
  defp page_title(:edit), do: "Edit Ware house"
end
