defmodule GreyWeb.PutawayLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.Putaways

  @impl true
  def update(%{putaway: putaway} = assigns, socket) do
    changeset = Putaways.change_putaway(putaway)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"putaway" => putaway_params}, socket) do
    changeset =
      socket.assigns.putaway
      |> Putaways.change_putaway(putaway_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"putaway" => putaway_params}, socket) do
    save_putaway(socket, socket.assigns.action, putaway_params)
  end

  defp save_putaway(socket, :edit, putaway_params) do
    case Putaways.update_putaway(socket.assigns.putaway, putaway_params) do
      {:ok, _putaway} ->
        {:noreply,
         socket
         |> put_flash(:info, "Putaway updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_putaway(socket, :new, putaway_params) do
    new_putaway =
      putaway_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Putaways.create_putaway(new_putaway) do
      {:ok, _putaway} ->
        {:noreply,
         socket
         |> put_flash(:info, "Putaway created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
