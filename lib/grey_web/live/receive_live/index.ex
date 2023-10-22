defmodule GreyWeb.ReceiveLive.Index do
  use GreyWeb, :admin_live_view

  alias Grey.Receives
  alias Grey.Receives.Receive
  alias Grey.Users
  alias Grey.Status

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:heading, "Recieves")
     |> assign(:subheading, "This is a list of all your recieved items")
     |> assign(:receives, list_receives())
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Receive")
    |> assign(:receive, Receives.get_receive!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Receive")
    |> assign(:receive, %Receive{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Receives")
    |> assign(:receive, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    receive = Receives.get_receive!(id)
    {:ok, _} = Receives.delete_receive(receive)

    {:noreply, assign(socket, :receives, list_receives())}
  end

  @impl true
  def handle_event("change_status", %{"id" => id, "schema" => schema}, socket) do
    Status.change_status(id, schema)

    {:noreply, assign(socket, :receives, list_receives())}
  end

  defp list_receives do
    Receives.list_receives()
  end
end
