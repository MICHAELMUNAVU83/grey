defmodule GreyWeb.StaffLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.Staffs

  @impl true
  def update(%{staff: staff} = assigns, socket) do
    changeset = Staffs.change_staff(staff)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"staff" => staff_params}, socket) do
    changeset =
      socket.assigns.staff
      |> Staffs.change_staff(staff_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"staff" => staff_params}, socket) do
    save_staff(socket, socket.assigns.action, staff_params)
  end

  defp save_staff(socket, :edit, staff_params) do
    case Staffs.update_staff(socket.assigns.staff, staff_params) do
      {:ok, _staff} ->
        {:noreply,
         socket
         |> put_flash(:info, "Staff updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_staff(socket, :new, staff_params) do
    new_staff_params =
      staff_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Staffs.create_staff(new_staff_params) do
      {:ok, _staff} ->
        {:noreply,
         socket
         |> put_flash(:info, "Staff created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
