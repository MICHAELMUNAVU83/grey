defmodule GreyWeb.ReceiveLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.Receives

  @impl true
  def update(%{receive: receive} = assigns, socket) do
    changeset = Receives.change_receive(receive)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"receive" => receive_params}, socket) do
    changeset =
      socket.assigns.receive
      |> Receives.change_receive(receive_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"receive" => receive_params}, socket) do
    save_receive(socket, socket.assigns.action, receive_params)
  end

  defp save_receive(socket, :edit, receive_params) do
    case Receives.update_receive(socket.assigns.receive, receive_params) do
      {:ok, _receive} ->
        {:noreply,
         socket
         |> put_flash(:info, "Receive updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_receive(socket, :new, receive_params) do
    new_receive_params =
      receive_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Receives.create_receive(new_receive_params) do
      {:ok, _receive} ->
        {:noreply,
         socket
         |> put_flash(:info, "Receive created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
