defmodule GreyWeb.RetailerLive.Index do
  use GreyWeb, :admin_live_view

  alias Grey.Retailers
  alias Grey.Retailers.Retailer
  alias Grey.Users
  alias Grey.Status

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:retailers, list_retailers())
     |> assign(:heading, "Retailers")
     |> assign(:subheading, "This is a list of all your retailers")
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Retailer")
    |> assign(:retailer, Retailers.get_retailer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Retailer")
    |> assign(:retailer, %Retailer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Retailers")
    |> assign(:retailer, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    retailer = Retailers.get_retailer!(id)
    {:ok, _} = Retailers.delete_retailer(retailer)

    {:noreply, assign(socket, :retailers, list_retailers())}
  end

  @impl true
  def handle_event("change_status", %{"id" => id, "schema" => schema}, socket) do
    Status.change_status(id, schema)

    {:noreply, assign(socket, :retailers, list_retailers())}
  end

  defp list_retailers do
    Retailers.list_retailers()
  end
end
