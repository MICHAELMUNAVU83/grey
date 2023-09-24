defmodule GreyWeb.WareHouseLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.WareHouses

  @impl true
  def update(%{ware_house: ware_house} = assigns, socket) do
    changeset = WareHouses.change_ware_house(ware_house)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"ware_house" => ware_house_params}, socket) do
    changeset =
      socket.assigns.ware_house
      |> WareHouses.change_ware_house(ware_house_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"ware_house" => ware_house_params}, socket) do
    save_ware_house(socket, socket.assigns.action, ware_house_params)
  end

  defp save_ware_house(socket, :edit, ware_house_params) do
    case WareHouses.update_ware_house(socket.assigns.ware_house, ware_house_params) do
      {:ok, _ware_house} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ware house updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_ware_house(socket, :new, ware_house_params) do
    warehouse_params =
      ware_house_params
      |> Map.put("user_id", socket.assigns.user.id)

    case WareHouses.create_ware_house(warehouse_params) do
      {:ok, _ware_house} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ware house created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
