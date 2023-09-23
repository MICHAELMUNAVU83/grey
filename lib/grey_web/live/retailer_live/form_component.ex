defmodule GreyWeb.RetailerLive.FormComponent do
  use GreyWeb, :live_component

  alias Grey.Retailers

  @impl true
  def update(%{retailer: retailer} = assigns, socket) do
    changeset = Retailers.change_retailer(retailer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"retailer" => retailer_params}, socket) do
    changeset =
      socket.assigns.retailer
      |> Retailers.change_retailer(retailer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"retailer" => retailer_params}, socket) do
    save_retailer(socket, socket.assigns.action, retailer_params)
  end

  defp save_retailer(socket, :edit, retailer_params) do
    case Retailers.update_retailer(socket.assigns.retailer, retailer_params) do
      {:ok, _retailer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Retailer updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_retailer(socket, :new, retailer_params) do
    new_retailer_params =
    retailer_params
      |> Map.put("user_id", socket.assigns.user.id)
      IO.inspect(new_retailer_params)

    case Retailers.create_retailer(new_retailer_params) do
      {:ok, _retailer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Retailer created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
