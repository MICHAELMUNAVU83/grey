defmodule GreyWeb.DispatchLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.Dispatches

  @impl true
  def update(%{dispatch: dispatch} = assigns, socket) do
    changeset = Dispatches.change_dispatch(dispatch)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"dispatch" => dispatch_params}, socket) do
    changeset =
      socket.assigns.dispatch
      |> Dispatches.change_dispatch(dispatch_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"dispatch" => dispatch_params}, socket) do
    save_dispatch(socket, socket.assigns.action, dispatch_params)
  end

  defp save_dispatch(socket, :edit, dispatch_params) do
    case Dispatches.update_dispatch(socket.assigns.dispatch, dispatch_params) do
      {:ok, _dispatch} ->
        {:noreply,
         socket
         |> put_flash(:info, "Dispatch updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_dispatch(socket, :new, dispatch_params) do
    new_dispatch_params =
    dispatch_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Dispatches.create_dispatch(new_dispatch_params) do
      {:ok, _dispatch} ->
        {:noreply,
         socket
         |> put_flash(:info, "Dispatch created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
