defmodule GreyWeb.ReceiveLive.Show do
  use GreyWeb, :live_view

  alias Grey.Receives

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:receive, Receives.get_receive!(id))}
  end

  defp page_title(:show), do: "Show Receive"
  defp page_title(:edit), do: "Edit Receive"
end
