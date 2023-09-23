defmodule GreyWeb.SupplierLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.Suppliers

  @impl true
  def update(%{supplier: supplier} = assigns, socket) do
    changeset = Suppliers.change_supplier(supplier)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"supplier" => supplier_params}, socket) do
    changeset =
      socket.assigns.supplier
      |> Suppliers.change_supplier(supplier_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"supplier" => supplier_params}, socket) do
    save_supplier(socket, socket.assigns.action, supplier_params)
  end

  defp save_supplier(socket, :edit, supplier_params) do
    case Suppliers.update_supplier(socket.assigns.supplier, supplier_params) do
      {:ok, _supplier} ->
        {:noreply,
         socket
         |> put_flash(:info, "Supplier updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_supplier(socket, :new, supplier_params) do
    new_supplier_params=
    supplier_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Suppliers.create_supplier(new_supplier_params) do
      {:ok, _supplier} ->
        {:noreply,
         socket
         |> put_flash(:info, "Supplier created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
