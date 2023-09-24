defmodule GreyWeb.DispatchLive.Show do
  use GreyWeb, :live_view

  alias Grey.Dispatches

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:dispatch, Dispatches.get_dispatch!(id))}
  end

  defp page_title(:show), do: "Show Dispatch"
  defp page_title(:edit), do: "Edit Dispatch"
end
