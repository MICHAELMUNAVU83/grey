defmodule GreyWeb.StorageLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.Storages

  @impl true
  def update(%{storage: storage} = assigns, socket) do
    changeset = Storages.change_storage(storage)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"storage" => storage_params}, socket) do
    changeset =
      socket.assigns.storage
      |> Storages.change_storage(storage_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"storage" => storage_params}, socket) do
    save_storage(socket, socket.assigns.action, storage_params)
  end

  defp save_storage(socket, :edit, storage_params) do
    case Storages.update_storage(socket.assigns.storage, storage_params) do
      {:ok, _storage} ->
        {:noreply,
         socket
         |> put_flash(:info, "Storage updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_storage(socket, :new, storage_params) do
    new_storage_params =
      storage_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Storages.create_storage(new_storage_params) do
      {:ok, _storage} ->
        {:noreply,
         socket
         |> put_flash(:info, "Storage created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
