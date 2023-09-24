defmodule GreyWeb.PutawayLive.Show do
  use GreyWeb, :live_view

  alias Grey.Putaways

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:putaway, Putaways.get_putaway!(id))}
  end

  defp page_title(:show), do: "Show Putaway"
  defp page_title(:edit), do: "Edit Putaway"
end
