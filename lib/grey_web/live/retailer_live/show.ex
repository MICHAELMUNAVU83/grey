defmodule GreyWeb.RetailerLive.Show do
  use GreyWeb, :live_view

  alias Grey.Retailers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:retailer, Retailers.get_retailer!(id))}
  end

  defp page_title(:show), do: "Show Retailer"
  defp page_title(:edit), do: "Edit Retailer"
end
