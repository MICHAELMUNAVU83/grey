defmodule GreyWeb.ReturnLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.Returns

  @impl true
  def update(%{return: return} = assigns, socket) do
    changeset = Returns.change_return(return)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"return" => return_params}, socket) do
    changeset =
      socket.assigns.return
      |> Returns.change_return(return_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"return" => return_params}, socket) do
    save_return(socket, socket.assigns.action, return_params)
  end

  defp save_return(socket, :edit, return_params) do
    case Returns.update_return(socket.assigns.return, return_params) do
      {:ok, _return} ->
        {:noreply,
         socket
         |> put_flash(:info, "Return updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_return(socket, :new, return_params) do
    new_return_params =
      return_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Returns.create_return(new_return_params) do
      {:ok, _return} ->
        {:noreply,
         socket
         |> put_flash(:info, "Return created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
