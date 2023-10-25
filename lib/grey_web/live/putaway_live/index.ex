defmodule GreyWeb.PutawayLive.Index do
  use GreyWeb, :admin_live_view

  alias Grey.Putaways
  alias Grey.Putaways.Putaway
  alias Grey.Users
  alias Grey.Status
  alias Grey.Receives
  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])
    receives = Receives.list_receives()

    {:ok,
     socket
     |> assign(:heading, "Putaways")
     |> assign(:subheading, "This is a list of all your putaways")
     |> assign(:putaways, list_putaways())
     |> assign(:user, user)
     |> assign(:receives, receives)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Putaway")
    |> assign(:putaway, Putaways.get_putaway!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Putaway")
    |> assign(:putaway, %Putaway{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Putaways")
    |> assign(:putaway, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    putaway = Putaways.get_putaway!(id)
    {:ok, _} = Putaways.delete_putaway(putaway)

    {:noreply, assign(socket, :putaways, list_putaways())}
  end

  @impl true
  def handle_event("change_status", %{"id" => id, "schema" => schema}, socket) do
    Status.change_status(id, schema)

    {:noreply, assign(socket, :putaways, list_putaways())}
  end

  defp list_putaways do
    Putaways.list_putaways()
  end
end
