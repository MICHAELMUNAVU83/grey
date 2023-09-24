defmodule GreyWeb.SupplierLive.Index do
  use GreyWeb, :live_view

  alias Grey.Suppliers
  alias Grey.Suppliers.Supplier
  alias Grey.Users

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:suppliers, list_suppliers())
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Supplier")
    |> assign(:supplier, Suppliers.get_supplier!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Supplier")
    |> assign(:supplier, %Supplier{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Suppliers")
    |> assign(:supplier, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    supplier = Suppliers.get_supplier!(id)
    {:ok, _} = Suppliers.delete_supplier(supplier)

    {:noreply, assign(socket, :suppliers, list_suppliers())}
  end

  defp list_suppliers do
    Suppliers.list_suppliers()
  end
end
