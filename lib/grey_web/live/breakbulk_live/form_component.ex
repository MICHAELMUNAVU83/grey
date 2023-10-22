defmodule GreyWeb.BreakbulkLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.Breakbulks

  @impl true
  def update(%{breakbulk: breakbulk} = assigns, socket) do
    changeset = Breakbulks.change_breakbulk(breakbulk)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"breakbulk" => breakbulk_params}, socket) do
    changeset =
      socket.assigns.breakbulk
      |> Breakbulks.change_breakbulk(breakbulk_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"breakbulk" => breakbulk_params}, socket) do
    save_breakbulk(socket, socket.assigns.action, breakbulk_params)
  end

  defp save_breakbulk(socket, :edit, breakbulk_params) do
    case Breakbulks.update_breakbulk(socket.assigns.breakbulk, breakbulk_params) do
      {:ok, _breakbulk} ->
        {:noreply,
         socket
         |> put_flash(:info, "Breakbulk updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_breakbulk(socket, :new, breakbulk_params) do
    IO.inspect(breakbulk_params)

    new_breakbulk =
      breakbulk_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Breakbulks.create_breakbulk(new_breakbulk) do
      {:ok, _breakbulk} ->
        {:noreply,
         socket
         |> put_flash(:info, "Breakbulk created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
