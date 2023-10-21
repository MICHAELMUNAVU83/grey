defmodule GreyWeb.DispatchLive.Index do
  use GreyWeb, :admin_live_view

  alias Grey.Dispatches
  alias Grey.Dispatches.Dispatch
  alias Grey.Users
  alias Grey.Status

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:heading, "Dispatches")
     |> assign(:subheading, "This is a list of all your dispatches")
     |> assign(:dispatches, list_dispatches())
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Dispatch")
    |> assign(:dispatch, Dispatches.get_dispatch!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Dispatch")
    |> assign(:dispatch, %Dispatch{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Dispatches")
    |> assign(:dispatch, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    dispatch = Dispatches.get_dispatch!(id)
    {:ok, _} = Dispatches.delete_dispatch(dispatch)

    {:noreply, assign(socket, :dispatches, list_dispatches())}
  end

  @impl true
  def handle_event("change_status", %{"id" => id, "schema" => schema}, socket) do
    Status.change_status(id, schema)

    {:noreply, assign(socket, :dispatches, list_dispatches())}
  end

  defp list_dispatches do
    Dispatches.list_dispatches()
  end
end
