defmodule GreyWeb.BreakbulkLive.Index do
  use GreyWeb, :admin_live_view

  alias Grey.Breakbulks
  alias Grey.Breakbulks.Breakbulk
  alias Grey.Users
  alias Grey.Status
  alias Grey.Receives

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])
    receives = Receives.list_receives()

    {:ok,
     socket
     |> assign(:heading, "BreakBulks")
     |> assign(:subheading, "This is a list of all your breakbulks")
     |> assign(:breakbulks, list_breakbulks())
     |> assign(:user, user)
     |> assign(:receives, receives)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Breakbulk")
    |> assign(:breakbulk, Breakbulks.get_breakbulk!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Breakbulk")
    |> assign(:breakbulk, %Breakbulk{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Breakbulks")
    |> assign(:breakbulk, nil)
  end

  @impl true
  def handle_event("change_status", %{"id" => id, "schema" => schema}, socket) do
    Status.change_status(id, schema)

    {:noreply, assign(socket, :breakbulks, list_breakbulks())}
  end

  def handle_event("toggle_display", params, socket) do
    IO.write("im here ")
    IO.inspect(params)
    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    breakbulk = Breakbulks.get_breakbulk!(id)
    {:ok, _} = Breakbulks.delete_breakbulk(breakbulk)

    {:noreply, assign(socket, :breakbulks, list_breakbulks())}
  end

  defp list_breakbulks do
    Breakbulks.list_breakbulks() |> Enum.reverse()
  end
end
