defmodule GreyWeb.StorageLive.Index do
  use GreyWeb, :admin_live_view

  alias Grey.Storages
  alias Grey.Storages.Storage
  alias Grey.Users

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:heading, "Storages")
     |> assign(:subheading, "This is a list of all your Storages")
     |> assign(:storages, list_storages())
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Storage")
    |> assign(:storage, Storages.get_storage!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Storage")
    |> assign(:storage, %Storage{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Storages")
    |> assign(:storage, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    storage = Storages.get_storage!(id)
    {:ok, _} = Storages.delete_storage(storage)

    {:noreply, assign(socket, :storages, list_storages())}
  end

  defp list_storages do
    Storages.list_storages()
  end
end
