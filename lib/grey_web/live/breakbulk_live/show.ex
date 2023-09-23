defmodule GreyWeb.BreakbulkLive.Show do
  use GreyWeb, :live_view

  alias Grey.Breakbulks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:breakbulk, Breakbulks.get_breakbulk!(id))}
  end

  defp page_title(:show), do: "Show Breakbulk"
  defp page_title(:edit), do: "Edit Breakbulk"
end
