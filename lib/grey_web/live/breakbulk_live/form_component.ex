defmodule GreyWeb.BreakbulkLive.FormComponent do
  use GreyWeb, :live_component
  require Ecto.Query
  require Ecto
  alias Grey.Breakbulks
  

  @impl true
  def update(%{breakbulk: breakbulk} = assigns, socket) do
    changeset = Breakbulks.change_breakbulk(breakbulk)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:form_count, 1)
     |> assign(:error, "")}
  end

  @impl true
  def handle_event("validate", params, socket) do
    changeset =
      socket.assigns.breakbulk
      |> Breakbulks.change_breakbulk(params)
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

  @impl true
  def handle_event("saver", params, socket) do
    status =
      if params["status"] == ["on"] do
        true
      else
        false
      end

    code = SecureRandom.hex(6)

    now =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    [items, quantities, uom] = [params["item"], params["quantity"], params["uom"]]

    items_to_add =
      Enum.zip(Enum.zip(items, quantities), uom)
      |> Enum.map(fn {item_qty, uom_value} ->
        {elem(item_qty, 0), elem(item_qty, 1), uom_value}
      end)
      |> Enum.map(fn {item, quantity, uom} ->
        %{
          items: item,
          quantity: quantity,
          uom: uom,
          user_id: socket.assigns.user.id,
          code: code,
          active: status,
          inserted_at: now,
          updated_at: now
        }
      end)

    # |> IO.inspect()

    case Breakbulks.add_all(items_to_add) do
      {_x, nil} ->
        {:noreply,
         socket
         |> put_flash(:info, "Breakbulk created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, "error in submitting"} ->
        {:noreply,
         socket
         |> put_flash(:error, "there is a problem in you submission")
         |> assign(
           :error,
           "there are some errors in you submission ..make sure you fill in all the fields with correct values"
         )}

      _ ->
        IO.write("im here")

        {:noreply, socket}
    end
  end
end
